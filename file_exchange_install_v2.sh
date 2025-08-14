#!/usr/bin/env bash
# install_PStorage_exchange.sh — PStorage per-user internal <-> external exchange installer (PoC)
set -Eeuo pipefail

# ===== 依你的環境調整（預設填你目前使用的值） =====
PStorage_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="/var/www/PStorage.ntuee.temp/data"
WEB_USER="www-data"

# 是否設定新用戶 Skeleton（預設啟用）
SETUP_SKELETON=1
SKELETON_DIR="/var/lib/PStorage-skeleton"   # 會放 internal/ 與 external/

# 是否為「既有用戶」補齊 internal/external/quarantine（可選：1 啟用、0 關閉）
PATCH_EXISTING_USERS=1

# ---- 通常不需改動 ----
require_root(){ [[ $EUID -eq 0 ]] || { echo "請用 root 執行（sudo bash install_PStorage_exchange.sh）"; exit 1; }; }

install_deps(){
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y
  apt-get install -y inotify-tools python3 coreutils jq
}

write_config(){
  cat >/etc/default/PStorage-exchange <<EOF
# ===== PStorage Exchange（per-user） 設定 =====
PStorage_ROOT="$PStorage_ROOT"
DATA_DIR="$DATA_DIR"
WEB_USER="$WEB_USER"

# 自動同步：1=on 0=off（或用 /var/lib/PStorage-exchange/AUTO_ON 旗標檔）
AUTO_EXCHANGE=1

# 掃描設定（可留空不用）
SCAN_MODE="off"        # off | log | enforce | quarantine
YARA_RULES=""          # 例：/usr/local/share/yara/*.yar
SCAN_TIMEOUT=20        # 秒
EOF
  chmod 644 /etc/default/PStorage-exchange
}

setup_skeleton(){
  [[ "${SETUP_SKELETON:-0}" = "1" ]] || return 0
  mkdir -p "$SKELETON_DIR/internal" "$SKELETON_DIR/external"
  chown -R "$WEB_USER:$WEB_USER" "$SKELETON_DIR" || true

  # 設定 skeletondirectory，讓「新使用者」建立時自動帶這兩個資料夾
  sudo -u "$WEB_USER" php "$PStorage_ROOT/occ" config:system:set skeletondirectory --value "$SKELETON_DIR"

  # 建議：同時啟用 Flow & 自動化標籤 App，並建立常用標籤（confidential/public）
  sudo -u "$WEB_USER" php "$PStorage_ROOT/occ" app:enable workflowengine || true
  sudo -u "$WEB_USER" php "$PStorage_ROOT/occ" app:enable files_automatedtagging || true
  sudo -u "$WEB_USER" php "$PStorage_ROOT/occ" tag:add confidential || true
  sudo -u "$WEB_USER" php "$PStorage_ROOT/occ" tag:add public || true

  cat <<'NOTE'

[提醒] 自動化標籤（Files automated tagging）請在 GUI 建兩條規則（目前無官方 occ 可建 Flow）：
  1) When "File created" AND File path matches */files/internal*  -> Assign tag: confidential
  2) When "File created" AND File path matches */files/external*  -> Assign tag: public

（之後可再用 Files access control 針對 confidential/public 做內外網限制）
NOTE
}

patch_existing_users(){
  [[ "${PATCH_EXISTING_USERS:-0}" = "1" ]] || return 0
  echo "[patch] 為既有使用者補齊 internal/external/quarantine ..."

  find "$DATA_DIR" -mindepth 2 -maxdepth 2 -type d -name files | while read -r fdir; do
    user="$(basename "$(dirname "$fdir")")"
    sudo -u "$WEB_USER" mkdir -p "$fdir/internal" "$fdir/external" "$fdir/quarantine"
    # 讓 PStorage 認得
    sudo -u "$WEB_USER" php "$PStorage_ROOT/occ" files:scan --path="$user/files" >/dev/null 2>&1 || true
  done
}

install_sync_script(){
  cat >/usr/local/bin/PStorage_exchange_sync.sh <<'EOF'
#!/usr/bin/env bash
set -Eeuo pipefail
# shellcheck disable=SC1091
source /etc/default/PStorage-exchange

STATE_DIR="/var/lib/PStorage-exchange"
RECENT="$STATE_DIR/recent.log"
FLAG_AUTO="$STATE_DIR/AUTO_ON"
OCC="$PStorage_ROOT/occ"

mkdir -p "$STATE_DIR"

ts_utc(){ date -u +%Y%m%dT%H%M%SZ; }
now(){ date +%s; }

# 目的端單檔掃描：讓 Web 介面立刻看到
scan_single(){
  local user="$1" side="$2" base="$3" path=""
  case "$side" in
    internal) path="$user/files/internal/$base" ;;
    external) path="$user/files/external/$base" ;;
    *) return 0 ;;
  esac
  sudo -u "$WEB_USER" php "$OCC" files:scan --path="$path" >/dev/null 2>&1 || true
}

ensure_user_dirs(){
  local user="$1"
  local uroot="$DATA_DIR/$user/files"
  [[ -d "$uroot" ]] || return 0
  sudo -u "$WEB_USER" mkdir -p "$uroot/internal" "$uroot/external" "$uroot/quarantine"
}

is_on(){ [[ "${AUTO_EXCHANGE:-0}" = "1" || -f "$FLAG_AUTO" ]]; }

hash_file(){ sha256sum -- "$1" | awk '{print $1}'; }

mark_recent(){
  local h="$1" user="$2" side="$3" t
  t="$(now)"; printf '%s %s %s %s\n' "$t" "$user" "$side" "$h" >> "$RECENT"
}

seen_recent(){
  local h="$1" user="$2" t_cut; t_cut=$(( $(now) - 90 ))
  awk -v h="$h" -v u="$user" -v c="$t_cut" '$1>=c && $2==u && $4==h{ok=1} END{exit ok?0:1}' "$RECENT" 2>/dev/null
}

gc_recent(){
  local t_cut=$(( $(now) - 600 ))
  [[ -f "$RECENT" ]] || return 0
  awk -v c="$t_cut" '$1>=c' "$RECENT" > "$RECENT.tmp" 2>/dev/null || true
  mv -f "$RECENT.tmp" "$RECENT" 2>/dev/null || true
}

scan_pre_copy(){
  # 回傳：0=允許 10=log-only 20=阻擋 30=隔離
  local f="$1"
  case "${SCAN_MODE:-off}" in
    off) return 0 ;;
    log) [[ -z "${YARA_RULES:-}" ]] && return 0 ;;
    enforce|quarantine)
      [[ -z "${YARA_RULES:-}" ]] && { echo "[exchange][WARN] SCAN_MODE=$SCAN_MODE 但未設 YARA_RULES"; return 0; }
      ;;
  esac
  if [[ -n "${YARA_RULES:-}" ]]; then
    local cmd="timeout ${SCAN_TIMEOUT:-20}s yara -r ${YARA_RULES} \"$f\""
    if ! eval "$cmd" >/dev/null 2>&1; then
      case "$SCAN_MODE" in
        log) echo "[exchange][SCAN][log-only] $f"; return 0 ;;
        enforce) echo "[exchange][SCAN][block] $f"; return 20 ;;
        quarantine) echo "[exchange][SCAN][quarantine] $f"; return 30 ;;
      esac
    fi
  fi
  return 0
}

copy_overwrite(){
  local src="$1" dst_dir="$2" base dest
  base="$(basename "$src")"; dest="$dst_dir/$base"
  if ! cp --reflink=auto -- "$src" "$dest" 2>/dev/null; then cp -- "$src" "$dest"; fi
  chown "$WEB_USER:$WEB_USER" "$dest"
  echo "$dest"
}

handle_event(){
  local path="$1" user="$2" side="$3" other_dir dest_side base dest hash uroot qdir
  [[ -f "$path" ]] || return 0
  [[ "$path" == *.part ]] && return 0
  [[ "$path" != *"/files_versions/"* && "$path" != *"/files_trashbin/"* && "$path" != *"/uploads/"* ]] || return 0

  if ! is_on; then echo "[exchange][skip] AUTO_EXCHANGE=off : $path"; return 0; fi

  case "$side" in
    internal) other_dir="$DATA_DIR/$user/files/external"; dest_side="external" ;;
    external) other_dir="$DATA_DIR/$user/files/internal"; dest_side="internal" ;;
    *) echo "[exchange][ERR] unknown side: $side"; return 1 ;;
  esac

  ensure_user_dirs "$user"

  hash="$(hash_file "$path")"
  gc_recent
  if seen_recent "$hash" "$user"; then
    echo "[exchange][skip] recent same content (loop protect) : $path"; return 0
  fi

  scan_pre_copy "$path"; rc=$?
  case "$rc" in
    0|10) : ;; 20) echo "[exchange][block] $path"; return 0 ;;
    30)
      base="$(basename "$path")"
      qdir="$DATA_DIR/$user/files/quarantine"
      mkdir -p "$qdir"
      q="$qdir/$(ts_utc)__${side}__${base}"
      if ! cp --reflink=auto -- "$path" "$q" 2>/dev/null; then cp -- "$path" "$q"; fi
      chown "$WEB_USER:$WEB_USER" "$q"
      echo "[exchange][quarantine] $path -> $q"; return 0 ;;
  esac

  dest="$(copy_overwrite "$path" "$other_dir")"
  base="$(basename "$dest")"
  echo "[exchange][sync] $user: $side -> $dest_side: $path -> $dest"

  scan_single "$user" "$dest_side" "$base"
  mark_recent "$hash" "$user" "$side"
}

main_loop(){
  # 監聽整個 data，但只處理 */files/(internal|external)/*
  inotifywait -m -r \
    -e close_write -e moved_to \
    --format '%w%f' \
    --exclude '(^|/)\.|(^.*/)(cache|uploads|files_trashbin|files_versions)(/|$)' \
    "$DATA_DIR" \
  | while IFS= read -r changed; do
      # 過濾成：/data/<user>/files/(internal|external)/...
      case "$changed" in
        "$DATA_DIR"/*/files/internal/*)
          user="${changed#${DATA_DIR}/}"; user="${user%%/*}"
          handle_event "$changed" "$user" "internal"
          ;;
        "$DATA_DIR"/*/files/external/*)
          user="${changed#${DATA_DIR}/}"; user="${user%%/*}"
          handle_event "$changed" "$user" "external"
          ;;
      esac
    done
}

main_loop
EOF
  chmod 700 /usr/local/bin/PStorage_exchange_sync.sh
  chown root:root /usr/local/bin/PStorage_exchange_sync.sh
}

install_service(){
  cat >/etc/systemd/system/PStorage-exchange-sync.service <<'EOF'
[Unit]
Description=PStorage per-user internal <-> external exchange (inotify)
After=network.target

[Service]
Type=simple
EnvironmentFile=/etc/default/PStorage-exchange
ExecStart=/usr/local/bin/PStorage_exchange_sync.sh
Restart=always
RestartSec=2
User=root

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  systemctl enable --now PStorage-exchange-sync.service
}

post_msg(){
  systemctl --no-pager --full status PStorage-exchange-sync.service || true
  cat <<'TIP'

✔ 安裝完成！（per-user internal/external 同步）

操作指令：
  # 追即時日誌
  journalctl -u PStorage-exchange-sync.service -f

  # 開/關自動同步（方式一：改設定）
  sudo sed -i 's/^AUTO_EXCHANGE=.*/AUTO_EXCHANGE=1/' /etc/default/PStorage-exchange
  sudo systemctl restart PStorage-exchange-sync.service
  # 關閉：改成 0 後重啟

  # 開/關自動同步（方式二：旗標檔）
  sudo touch /var/lib/PStorage-exchange/AUTO_ON        # 開
  sudo rm -f /var/lib/PStorage-exchange/AUTO_ON        # 關

[提醒]
  1) 已將 skeletondirectory 設為包含 internal/external 的路徑，之後新用戶會自動擁有兩個資料夾
  2) 請在 GUI 建立 Files automated tagging 規則（internal->confidential、external->public）
  3) 若要啟用 YARA：請填寫 /etc/default/PStorage-exchange 的 YARA_RULES 並將 SCAN_MODE 設為 enforce/quarantine

TIP
}

main(){
  require_root
  install_deps
  write_config
  setup_skeleton
  patch_existing_users
  install_sync_script
  install_service
  post_msg
}
main
