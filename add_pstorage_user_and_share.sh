#!/usr/bin/env bash
# add_pstorage_user_and_share.sh
# 建新帳號 → 建 internal/external → 分享給 admin → admin 端改名/歸檔
set -Eeuo pipefail

### ====== 環境依你的安裝調整 ======
PSTORAGE_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="$PSTORAGE_ROOT/data"
WEB_USER="www-data"
BASE_URL="https://pstorage.ntuee.temp"     # 你的 PStorage/Nextcloud 站台 URL
ADMIN_USER="admin"

### ====== 參數與選項 ======
INSECURE=0  # 自簽憑證時，可用 --insecure 跳過 TLS 驗證

usage() {
  cat <<EOF
用法：
  sudo bash $0 -u <username> -p <password> [-n <displayName>] -A <adminPassword> [--insecure]

參數：
  -u  新使用者帳號
  -p  新使用者預設密碼（之後使用者可自行修改）
  -n  顯示名稱（可省略，預設 = 帳號）
  -A  admin 的密碼（或 App Password），用於 admin 端改名/歸檔
  --insecure  使用自簽憑證時加入（curl 以 -k 連線）

環境變數（如未修改預設值）：
  PSTORAGE_ROOT=$PSTORAGE_ROOT
  DATA_DIR=$DATA_DIR
  WEB_USER=$WEB_USER
  BASE_URL=$BASE_URL
  ADMIN_USER=$ADMIN_USER
EOF
}

[[ $EUID -eq 0 ]] || { echo "請以 root 執行（sudo）"; exit 1; }

need_bin() { command -v "$1" >/dev/null 2>&1 || { echo "缺少工具：$1"; exit 1; }; }
need_bin curl
need_bin jq

USER=""
PASS=""
DNAME=""
ADMIN_PASS=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -u) USER="$2"; shift 2;;
    -p) PASS="$2"; shift 2;;
    -n) DNAME="$2"; shift 2;;
    -A) ADMIN_PASS="$2"; shift 2;;
    --insecure) INSECURE=1; shift;;
    -h|--help) usage; exit 0;;
    *) echo "未知參數：$1"; usage; exit 1;;
  esac
done

[[ -n "$USER" && -n "$PASS" && -n "$ADMIN_PASS" ]] || { usage; exit 1; }
[[ -n "$DNAME" ]] || DNAME="$USER"

CURLFLAGS=(-sS)
[[ "$INSECURE" = "1" ]] && CURLFLAGS+=(-k)

OCC() { sudo -u "$WEB_USER" php "$PSTORAGE_ROOT/occ" "$@"; }

echo "== 1) 建立使用者：$USER"
# 若已存在，occ 會失敗；做 idempotent：存在就略過
if ! OCC user:info "$USER" >/dev/null 2>&1; then
  # --password-from-env：用 stdin 填兩次密碼
  printf '%s\n%s\n' "$PASS" "$PASS" | OCC user:add --password-from-env --display-name "$DNAME" "$USER"
else
  echo "使用者 $USER 已存在，略過新增。"
fi

echo "== 2) 建立 internal / external 目錄（不更動名稱）"
sudo -u "$WEB_USER" mkdir -p "$DATA_DIR/$USER/files/internal" "$DATA_DIR/$USER/files/external"
chown -R "$WEB_USER:$WEB_USER" "$DATA_DIR/$USER/files"
OCC files:scan --path="$USER/files" >/dev/null

echo "== 3) 以使用者身分分享給 $ADMIN_USER（權限 13：讀/建/刪）"
share_path() {
  local owner="$1" pass="$2" rel="$3"
  curl "${CURLFLAGS[@]}" -u "$owner:$pass" \
    -H 'OCS-APIRequest: true' -H 'Accept: application/json' \
    -d "path=$rel" -d 'shareType=0' -d "shareWith=$ADMIN_USER" -d 'permissions=13' \
    -X POST "$BASE_URL/ocs/v2.php/apps/files_sharing/api/v1/shares" \
    | jq -r '.ocs.meta.statuscode,.ocs.meta.message' \
    | paste - - | while read -r code msg; do
        if [[ "$code" != "100" && "$code" != "200" ]]; then
          echo "  [ERR] 分享 $rel 失敗：($code) $msg"
          exit 1
        else
          echo "  [OK] $rel 已分享給 $ADMIN_USER"
        fi
      done
}
share_path "$USER" "$PASS" "/internal"
share_path "$USER" "$PASS" "/external"

echo "== 4) 在 admin 視圖改名與歸檔（不影響使用者實體路徑）"
# 建立 /Users/<user>/ 容器
mkcol() {
  local url="$1"
  curl "${CURLFLAGS[@]}" -u "$ADMIN_USER:$ADMIN_PASS" -X MKCOL "$url" >/dev/null || true
}
enc() { python3 - <<'PY' "$1"
import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1], safe="/()_-.")) 
PY
}
ADMIN_ROOT_DAV="$BASE_URL/remote.php/dav/files/$ADMIN_USER"
mkcol "$(enc "$ADMIN_ROOT_DAV/Users")"
mkcol "$(enc "$ADMIN_ROOT_DAV/Users/$USER")"

# 查 admin 端「與我共享」清單，找出 owner=$USER 的兩筆分享的掛載點（file_target）
list_shared_with_me() {
  curl "${CURLFLAGS[@]}" -u "$ADMIN_USER:$ADMIN_PASS" \
    -H 'OCS-APIRequest: true' -H 'Accept: application/json' \
    "$BASE_URL/ocs/v2.php/apps/files_sharing/api/v1/shares?shared_with_me=true"
}
# 取出最新一版（owner=USER 且 path=/internal|/external）的 file_target
get_target_for() {
  local want="$1" # "/internal" or "/external"
  list_shared_with_me | jq -r --arg u "$USER" --arg p "$want" '
    .ocs.data | map(select(.uid_owner==$u and .path==$p)) 
    | sort_by(.id) | last | .file_target // empty
  '
}

move_mount() {
  local from_rel="$1" to_rel="$2"
  local SRC="$(enc "$ADMIN_ROOT_DAV$from_rel")"
  local DST="$(enc "$ADMIN_ROOT_DAV$to_rel")"
  # 若目標已存在，先附加時間尾碼避免衝突
  curl "${CURLFLAGS[@]}" -u "$ADMIN_USER:$ADMIN_PASS" -X MOVE "$SRC" -H "Destination: $DST" >/dev/null || {
    ts="$(date -u +%Y%m%dT%H%M%SZ)"
    DST="$(enc "$ADMIN_ROOT_DAV${to_rel}_$ts")"
    curl "${CURLFLAGS[@]}" -u "$ADMIN_USER:$ADMIN_PASS" -X MOVE "$SRC" -H "Destination: $DST" >/dev/null
  }
}

# 等待分享在 admin 端可見（輪詢最多 30s）
wait_and_move() {
  local want="$1" newname="$2"
  local tries=30 file_target=""
  while (( tries-- > 0 )); do
    file_target="$(get_target_for "$want")"
    [[ -n "$file_target" ]] && break
    sleep 1
  done
  if [[ -z "$file_target" ]]; then
    echo "  [WARN] 找不到 owner=$USER 的 $want 掛載點（可能延遲）；略過改名。"
    return 0
  fi
  echo "  [OK] 取得掛載點：$file_target"
  move_mount "$file_target" "/Users/$USER/$newname"
  echo "  [OK] 已移動/改名為：/Users/$USER/$newname"
}

wait_and_move "/internal" "internal_${USER}"
wait_and_move "/external" "external_${USER}"

echo "== 完成：$USER 已建立、分享給 $ADMIN_USER，且 admin 視圖已歸檔改名。"
