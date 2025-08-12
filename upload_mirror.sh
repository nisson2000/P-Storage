#!/usr/bin/env bash
set -Eeuo pipefail

# === 依環境調整 ===
NC_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="/var/www/PStorage.ntuee.temp/data"
OCC="$NC_ROOT/occ"
AUDIT_DIR="$DATA_DIR/admin/files/audit"
WEB_USER="www-data"

# 建立 audit 目錄（若不存在）
sudo -u "$WEB_USER" mkdir -p "$AUDIT_DIR"

# 以 UTC 產生 timestamp
ts_utc() { date -u +%Y%m%dT%H%M%SZ; }

# 是否要處理的路徑（僅 /data/<user>/files/...）
is_nc_user_file() {
  local p="$1"
  [[ "$p" == "$DATA_DIR/"*"/files/"* ]] || return 1
  [[ "$p" != "$AUDIT_DIR/"* ]] || return 1
  [[ "$p" != *"/files_trashbin/"* && "$p" != *"/files_versions/"* && "$p" != *"/uploads/"* ]] || return 1
  [[ "$p" != *.part ]] || return 1
  [[ -f "$p" ]] || return 1
  return 0
}

# 掃描讓 NC 認得新檔（掃描單一檔案路徑）
scan_admin_audit() {
  local fname="$1" # 僅檔名
  sudo -u "$WEB_USER" php "$OCC" files:scan --path="admin/files/audit/$fname" >/dev/null
}

# 主程式：監聽 close_write 與 moved_to
inotifywait -m -r \
  -e close_write -e moved_to \
  --format '%w%f' \
  --exclude '(^|/)\.|(^.*/)(cache|uploads|files_trashbin|files_versions)(/|$)|(^.*/admin/files/audit/)' \
  "$DATA_DIR" | while IFS= read -r PATH_CHANGED; do
    if is_nc_user_file "$PATH_CHANGED"; then
      base="$(basename "$PATH_CHANGED")"
      # 產生鏡像檔名：<原檔名>__upload__<UTC>
      out_name="${base}__upload__$(ts_utc)"
      dest="$AUDIT_DIR/$out_name"
      # 複製（支援 reflink 可快照；失敗時退回一般 cp）
      if ! cp --reflink=auto -- "$PATH_CHANGED" "$dest" 2>/dev/null; then
        cp -- "$PATH_CHANGED" "$dest"
      fi
      chown "$WEB_USER:$WEB_USER" "$dest"
      scan_admin_audit "$out_name"
      echo "[upload-mirror] $PATH_CHANGED -> $dest"
    fi
  done
