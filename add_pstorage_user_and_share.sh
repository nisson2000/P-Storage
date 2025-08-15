#!/usr/bin/env bash
# add_pstorage_user_and_share.sh
# 建新帳號 → 建 internal/external → 分享給 admin → admin 端改名/歸檔
set -Eeuo pipefail

### ====== 環境依你的安裝調整 ======
PSTORAGE_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="$PSTORAGE_ROOT/data"
WEB_USER="www-data"
BASE_URL="https://pstorage.ntuee.temp:3000"     # 你的 PStorage/Nextcloud 站台 URL
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
  printf '%s\n%s\n' "$PASS" "$PASS" | OCC user:add --display-name "$DNAME" "$USER"
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

# --- 假設：BASE_URL 不以 / 結尾，帳號/資料夾無空白與非 ASCII 字元 ---
BASE_URL="${BASE_URL%/}"                           # 例如 https://pstorage.ntuee.temp:3000
ADMIN_DAV="/remote.php/dav/files/$ADMIN_USER"      # admin 的 WebDAV 根徑（只放 path）

# 簡單安全檢查（有特殊字元就中止，避免 MOVE/MKCOL 失敗）
if [[ ! "$USER" =~ ^[A-Za-z0-9._-]+$ ]]; then
  echo "[ERR] 使用者名稱含特殊字元：$USER（簡化模式不支援）"; exit 1
fi

mkcol_path() {  # 只給 path（不含 BASE_URL）；失敗視為已存在
  local path="$1"
  curl "${CURLFLAGS[@]}" -u "$ADMIN_USER:$ADMIN_PASS" \
       -X MKCOL "$BASE_URL$path" >/dev/null || true
}

move_path() {   # from/to 都是 path；目標存在則自動加時間尾碼
  local from="$1" to="$2"
  if ! curl "${CURLFLAGS[@]}" -u "$ADMIN_USER:$ADMIN_PASS" \
        -X MOVE "$BASE_URL$from" -H "Destination: $BASE_URL$to" >/dev/null; then
    local ts; ts="$(date -u +%Y%m%dT%H%M%SZ)"
    curl "${CURLFLAGS[@]}" -u "$ADMIN_USER:$ADMIN_PASS" \
         -X MOVE "$BASE_URL$from" -H "Destination: $BASE_URL${to}_$ts" >/dev/null
  fi
}

# 取 admin 端「與我共享」清單（JSON）
list_shared_with_me() {
  curl "${CURLFLAGS[@]}" -u "$ADMIN_USER:$ADMIN_PASS" \
    -H 'OCS-APIRequest: true' -H 'Accept: application/json' \
    "$BASE_URL/ocs/v2.php/apps/files_sharing/api/v1/shares?shared_with_me=true"
}

# 抓 owner=$USER 且 path=/internal|/external 的最新掛載點 file_target（如 /internal）
get_file_target_for() {
  local want="$1"
  list_shared_with_me | jq -r --arg u "$USER" --arg p "$want" '
    .ocs.data | map(select(.uid_owner==$u and .path==$p))
    | sort_by(.id) | last | .file_target // empty
  '
}

# 建 /Users 與 /Users/<user>
mkcol_path "$ADMIN_DAV/Users"
mkcol_path "$ADMIN_DAV/Users/$USER"

wait_and_move() {
  local want="$1" newname="$2"
  local tries=30 file_target=""
  while (( tries-- > 0 )); do
    file_target="$(get_file_target_for "$want")"  # e.g. /internal
    [[ -n "$file_target" ]] && break
    sleep 1
  done
  if [[ -z "$file_target" ]]; then
    echo "  [WARN] 找不到 owner=$USER 的 $want 掛載點（可能有延遲），略過改名"; return 0
  fi
  echo "  [OK] 取得掛載點：$file_target"

  # from = /remote.php/dav/files/admin + file_target
  # to   = /remote.php/dav/files/admin/Users/<user>/<newname>
  local FROM="$ADMIN_DAV$file_target"
  local TO="$ADMIN_DAV/Users/$USER/$newname"

  move_path "$FROM" "$TO"
  echo "  [OK] 已移動/改名為：/Users/$USER/$newname"
}

wait_and_move "/internal" "internal_${USER}"
wait_and_move "/external" "external_${USER}"


echo "== 完成：$USER 已建立、分享給 $ADMIN_USER，且 admin 視圖已歸檔改名。"
