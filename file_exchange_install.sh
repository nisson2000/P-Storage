#!/usr/bin/env bash
# install_nc_exchange.sh — Nextcloud internal <-> external exchange (PoC) installer (auto-scan enabled)
set -Eeuo pipefail

# ===== 依你的環境調整（預設為你目前的值） =====
NC_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="/var/www/PStorage.ntuee.temp/data"
WEB_USER="www-data"
ADMIN_USER="admin"

# ---- 通常不需改動 ----
SRC_INTERNAL="$DATA_DIR/$ADMIN_USER/files/internal"
SRC_EXTERNAL="$DATA_DIR/$ADMIN_USER/files/external"
QUAR_DIR="$DATA_DIR/$ADMIN_USER/files/quarantine"

require_root(){ [[ $EUID -eq 0 ]] || { echo "請用 root 執行（sudo bash install_nc_exchange.sh）"; exit 1; }; }

install_deps(){
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y
  apt-get install -y inotify-tools python3 coreutils
}

write_config(){
  cat >/etc/default/nc-exchange <<EOF
# ===== Nextcloud Exchange PoC 設定 =====
NC_ROOT="$NC_ROOT"
DATA_DIR="$DATA_DIR"
WEB_USER="$WEB_USER"
ADMIN_USER="$ADMIN_USER"

SRC_INTERNAL="$SRC_INTERNAL"
SRC_EXTERNAL="$SRC_EXTERNAL"
DST_INTERNAL="\$SRC_INTERNAL"
DST_EXTERNAL="\$SRC_EXTERNAL"
AUDIT_DIR="\$DATA_DIR/\$ADMIN_USER/files/audit"
QUAR_DIR="$QUAR_DIR"

# 自動同步：1=on 0=off（或用 /var/lib/nc-exchange/AUTO_ON 旗標檔）
AUTO_EXCHANGE=1

# 掃描設定（可留空不用）
SCAN_MODE="enforce"     # off | log | enforce | quarantine
YARA_RULES=""           # 例：/usr/local/share/yara/*.yar
SCAN_TIMEOUT=20         # 秒
EOF
  chmod 644 /etc/default/nc-exchange
}

create_nc_dirs(){
  sudo -u "$WEB_USER" mkdir -p "$SRC_INTERNAL" "$SRC_EXTERNAL" "$QUAR_DIR"
  sudo -u "$WEB_USER" php "$NC_ROOT/occ" files:scan --path="$ADMIN_USER/files" >/dev/null
}

install_sync_script(){
  cat >/usr/local/bin/nc_exchange_sync.sh <<'EOF'
#!/usr/bin/env bash
set -Eeuo pipefail
# shellcheck disable=SC1091
source /etc/default/nc-exchange

OCC="$NC_ROOT/occ"
STATE_DIR="/var/lib/nc-exchange"
RECENT="$STATE_DIR/recent.log"
FLAG_AUTO="$STATE_DIR/AUTO_ON"

mkdir -p "$STATE_DIR" "$QUAR_DIR"
chown "$WEB_USER:$WEB_USER" "$QUAR_DIR" || true

ts_utc(){ date -u +%Y%m%dT%H%M%SZ; }
now(){ date +%s; }

is_on(){ [[ "${AUTO_EXCHANGE:-0}" = "1" || -f "$FLAG_AUTO" ]]; }

hash_file(){ sha256sum -- "$1" | awk '{print $1}'; }

mark_recent(){ printf '%s %s %s\n' "$(now)" "$2" "$1" >> "$RECENT"; }

seen_recent(){
  local h="$1" t_cut; t_cut=$(( $(now) - 90 ))
  awk -v h="$h" -v c="$t_cut" '$1>=c && $3==h{ok=1} END{exit ok?0:1}' "$RECENT" 2>/dev/null
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

scan_single(){
  # 目的側單檔掃描，讓 Web 介面立即顯示
  local side="$1" base="$2" path=""
  case "$side" in
    internal) path="$ADMIN_USER/files/internal/$base" ;;
    external) path="$ADMIN_USER/files/external/$base" ;;
    *) return 0 ;;
  esac
  sudo -u "$WEB_USER" php "$OCC" files:scan --path="$path" >/dev/null 2>&1 || true
}

copy_overwrite(){
  local src="$1" dst_dir="$2" base dest
  base="$(basename "$src")"; dest="$dst_dir/$base"
  if ! cp --reflink=auto -- "$src" "$dest" 2>/dev/null; then cp -- "$src" "$dest"; fi
  chown "$WEB_USER:$WEB_USER" "$dest"
  printf '%s\n' "$base"
}

handle_event(){
  local path="$1" side="$2" other_dir hash base dest_side
  [[ -f "$path" ]] || return 0
  [[ "$path" == *.part ]] && return 0
  [[ "$path" != *"/files_versions/"* && "$path" != *"/files_trashbin/"* && "$path" != *"/uploads/"* ]] || return 0

  if ! is_on; then echo "[exchange][skip] AUTO_EXCHANGE=off : $path"; return 0; fi

  case "$side" in
    internal) other_dir="$DST_EXTERNAL"; dest_side="external" ;;
    external) other_dir="$DST_INTERNAL"; dest_side="internal" ;;
    *) echo "[exchange][ERR] unknown side: $side"; return 1 ;;
  esac

  hash="$(hash_file "$path")"
  gc_recent
  if seen_recent "$hash"; then
    echo "[exchange][skip] recent same content (loop protect) : $path"; return 0
  fi

  scan_pre_copy "$path"; rc=$?
  case "$rc" in
    0|10) : ;;
    20) echo "[exchange][block] $path"; return 0 ;;
    30)
       base="$(basename "$path")"
       q="$QUAR_DIR/$(ts_utc)__${side}__${base}"
       if ! cp --reflink=auto -- "$path" "$q" 2>/dev/null; then cp -- "$path" "$q"; fi
       chown "$WEB_USER:$WEB_USER" "$q"
       echo "[exchange][quarantine] $path -> $q"; return 0 ;;
  esac

  base="$(copy_overwrite "$path" "$other_dir")"
  echo "[exchange][sync] $side -> $dest_side: $path -> $other_dir/$base"

  # 新增：目的側單檔掃描，立即出現在 Web 介面
  scan_single "$dest_side" "$base"

  mark_recent "$hash" "$side"
}

main_loop(){
  inotifywait -m -r \
    -e close_write -e moved_to \
    --format '%w%f' \
    --exclude '(^|/)\.|(^.*/)(cache|uploads|files_trashbin|files_versions)(/|$)' \
    "$SRC_INTERNAL" "$SRC_EXTERNAL" \
  | while IFS= read -r changed; do
      case "$changed" in
        "$SRC_INTERNAL"/*) handle_event "$changed" "internal" ;;
        "$SRC_EXTERNAL"/*) handle_event "$changed" "external" ;;
      esac
    done
}

[[ -d "$SRC_INTERNAL" && -d "$SRC_EXTERNAL" ]] || { echo "[exchange][ERR] internal/external 不存在"; exit 1; }
main_loop
EOF
  chmod 700 /usr/local/bin/nc_exchange_sync.sh
  chown root:root /usr/local/bin/nc_exchange_sync.sh
}

install_service(){
  cat >/etc/systemd/system/nc-exchange-sync.service <<'EOF'
[Unit]
Description=Nextcloud internal <-> external exchange PoC (inotify + auto scan)
After=network.target

[Service]
Type=simple
EnvironmentFile=/etc/default/nc-exchange
ExecStart=/usr/local/bin/nc_exchange_sync.sh
Restart=always
RestartSec=2
User=root

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  systemctl enable --now nc-exchange-sync.service
}

post_msg(){
  systemctl --no-pager --full status nc-exchange-sync.service || true
  cat <<'TIP'

✔ 安裝完成（已啟用「目的側單檔 files:scan」— Web 介面會立即顯示）。

常用操作：
  journalctl -u nc-exchange-sync.service -f
  # 開/關自動同步（改設定值）
  sudo sed -i 's/^AUTO_EXCHANGE=.*/AUTO_EXCHANGE=1/' /etc/default/nc-exchange
  sudo systemctl restart nc-exchange-sync.service
  # 或用旗標檔
  sudo touch /var/lib/nc-exchange/AUTO_ON   # 開
  sudo rm -f /var/lib/nc-exchange/AUTO_ON   # 關

啟用 YARA（選用）：
  sudo sed -i 's|^YARA_RULES=.*|YARA_RULES="/usr/local/share/yara/*.yar"|' /etc/default/nc-exchange
  sudo sed -i 's|^SCAN_MODE=.*|SCAN_MODE="enforce"|' /etc/default/nc-exchange
  sudo systemctl restart nc-exchange-sync.service

TIP
}

main(){
  require_root
  install_deps
  write_config
  create_nc_dirs
  install_sync_script
  install_service
  post_msg
}
main

