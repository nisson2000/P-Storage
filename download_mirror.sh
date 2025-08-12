#!/usr/bin/env bash
set -Eeuo pipefail

# === 依環境調整 ===
NC_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="/var/www/PStorage.ntuee.temp/data"
OCC="$NC_ROOT/occ"
AUDIT_DIR="$DATA_DIR/admin/files/audit"
WEB_USER="www-data"
LOG_FILE="/var/log/apache2/PStorage.ntuee.temp_access.log"   # ← 這裡換成你的 access log

sudo -u "$WEB_USER" mkdir -p "$AUDIT_DIR"

ts_utc() { date -u +%Y%m%dT%H%M%SZ; }

url_decode() {
  python3 - <<PY
import sys, urllib.parse
print(urllib.parse.unquote(sys.argv[1]))
PY
}

scan_admin_audit() {
  local fname="$1"
  sudo -u "$WEB_USER" php "$OCC" files:scan --path="admin/files/audit/$fname" >/dev/null
}

# 只抓 WebDAV 下載：GET /remote.php/dav/files/<user>/<path>
tail -F "$LOG_FILE" | \
grep --line-buffered 'GET /remote.php/dav/files/' | \
while IFS= read -r line; do
  # 抓取 URL path
  path_enc="$(echo "$line" | grep -oP 'GET\s+\K/remote\.php/dav/files/[^\s?"]+')"
  [[ -n "${path_enc:-}" ]] || continue

  # 解碼成 /remote.php/dav/files/USERNAME/relative/path
  path_dec="$(url_decode "$path_enc")"

  # 取出 USERNAME 與相對路徑
  user="$(echo "$path_dec" | cut -d'/' -f6)"
  rel_path="$(echo "$path_dec" | cut -d'/' -f7-)"
  [[ -n "${user:-}" && -n "${rel_path:-}" ]] || continue

  src="$DATA_DIR/$user/files/$rel_path"
  [[ -f "$src" ]] || continue

  base="$(basename "$src")"
  out_name="$(ts_utc)__${user}__download__${base}"
  dest="$AUDIT_DIR/$out_name"

  if ! cp --reflink=auto -- "$src" "$dest" 2>/dev/null; then
    cp -- "$src" "$dest"
  fi
  chown "$WEB_USER:$WEB_USER" "$dest"
  scan_admin_audit "$out_name"
  echo "[download-mirror] $src -> $dest"
done

