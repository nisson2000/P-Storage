#!/usr/bin/env bash
set -Eeuo pipefail

# === 依你的環境調整（很重要） ===
NC_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="/var/www/PStorage.ntuee.temp/data"
OCC="$NC_ROOT/occ"
AUDIT_DIR="$DATA_DIR/admin/files/audit"
WEB_USER="www-data"
LOG_FILE="/var/log/apache2/PStorage.ntuee.temp_access.log"

DEBUG=1   # 設 1 會多列印 debug 訊息；穩定後可改 0

mkdir -p "$AUDIT_DIR"

ts_utc() { date -u +%Y%m%dT%H%M%SZ; }

url_decode() {
  python3 - "$1" <<'PY'
import sys, urllib.parse
arg = sys.argv[1] if len(sys.argv) > 1 else ""
print(urllib.parse.unquote(arg))
PY
}

scan_admin_audit() {
  local fname="$1"
  sudo -u "$WEB_USER" php "$OCC" files:scan --path="admin/files/audit/$fname" >/dev/null 2>&1 || true
}

logd() { [[ "${DEBUG:-0}" = "1" ]] && echo "[download-mirror][DBG] $*"; }

# 追 access log，僅篩出含 remote.php/dav/files 的 GET
tail -F "$LOG_FILE" | \
grep -E --line-buffered 'GET .*(/index\.php/)?remote\.php/dav/files/' | \
while IFS= read -r line; do
  # 直接用 Perl 正則把 URL 擷取出來（不依賴雙引號）
  url_path_enc="$(perl -ne 'print "$1\n" if m{GET\s+(\S*remote\.php/dav/files/\S*)}i' <<<"$line")"
  [[ -n "${url_path_enc:-}" ]] || { logd "no url extracted"; continue; }

  # 去掉可能的 /index.php/ 前綴
  url_path_enc="${url_path_enc#/index.php/}"

  # 只處理 /remote.php/dav/files/...
  [[ "$url_path_enc" == /remote.php/dav/files/* ]] || { logd "skip non-webdav: $url_path_enc"; continue; }

  # 取出 user/relative/path（仍為編碼態）
  rest_enc="${url_path_enc#/remote.php/dav/files/}"
  [[ -n "$rest_enc" ]] || { logd "empty rest_enc"; continue; }

  # URL decode
  rest_dec="$(url_decode "$rest_enc")"
  [[ -n "$rest_dec" ]] || { logd "empty rest_dec"; continue; }

  # 切使用者與相對路徑
  user="${rest_dec%%/*}"
  rel_path="${rest_dec#*/}"
  [[ -n "$user" && -n "$rel_path" && "$rel_path" != "$rest_dec" ]] || { logd "bad split: $rest_dec"; continue; }

  src="$DATA_DIR/$user/files/$rel_path"
  if [[ ! -f "$src" ]]; then
    logd "not a regular file: $src"
    continue
  fi

  base="$(basename "$src")"
  out_name="${base}__download__$(ts_utc)__from__${user}"
  dest="$AUDIT_DIR/$out_name"

  if ! cp --reflink=auto -- "$src" "$dest" 2>/dev/null; then
    cp -- "$src" "$dest"
  fi
  chown "$WEB_USER:$WEB_USER" "$dest"
  scan_admin_audit "$out_name"
  echo "[download-mirror] $src -> $dest"
done