#!/usr/bin/env bash
# install_nc_audit.sh — File Mirror (upload + download) one-click installer
set -Eeuo pipefail

# ====== 依你的環境調整（預設為你目前的值）======
NC_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="/var/www/PStorage.ntuee.temp/data"
OCC="$NC_ROOT/occ"
WEB_USER="www-data"
ADMIN_USER="admin"
AUDIT_DIR="$DATA_DIR/$ADMIN_USER/files/audit"
LOG_FILE="/var/log/apache2/PStorage.ntuee.temp_access.log"

require_root() { [[ $EUID -eq 0 ]] || { echo "請用 root 執行"; exit 1; }; }

install_deps() {
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -y
  apt-get install -y inotify-tools python3 perl
}

create_audit_dir() {
  sudo -u "$WEB_USER" mkdir -p "$AUDIT_DIR"
  sudo -u "$WEB_USER" php "$OCC" files:scan --path="$ADMIN_USER/files/audit" >/dev/null
}

install_scripts() {
  # ---- upload mirror ----
  cat >/usr/local/bin/nc_audit_upload_mirror.sh <<'EOF'
#!/usr/bin/env bash
set -Eeuo pipefail

# === 依環境調整 ===
NC_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="/var/www/PStorage.ntuee.temp/data"
OCC="$NC_ROOT/occ"
AUDIT_DIR="$DATA_DIR/admin/files/audit"
WEB_USER="www-data"

sudo -u "$WEB_USER" mkdir -p "$AUDIT_DIR"
ts_utc() { date -u +%Y%m%dT%H%M%SZ; }

is_nc_user_file() {
  local p="$1"
  [[ "$p" == "$DATA_DIR/"*"/files/"* ]] || return 1
  [[ "$p" != "$AUDIT_DIR/"* ]] || return 1
  [[ "$p" != *"/files_trashbin/"* && "$p" != *"/files_versions/"* && "$p" != *"/uploads/"* ]] || return 1
  [[ "$p" != *.part ]] || return 1
  [[ -f "$p" ]] || return 1
  return 0
}

scan_admin_audit() {
  local fname="$1"
  sudo -u "$WEB_USER" php "$OCC" files:scan --path="admin/files/audit/$fname" >/dev/null
}

inotifywait -m -r -e close_write -e moved_to \
  --format '%w%f' \
  --exclude '(^|/)\.|(^.*/)(cache|uploads|files_trashbin|files_versions)(/|$)|(^.*/admin/files/audit/)' \
  "$DATA_DIR" | while IFS= read -r PATH_CHANGED; do
  if is_nc_user_file "$PATH_CHANGED"; then
    base="$(basename "$PATH_CHANGED")"
    rel="${PATH_CHANGED#${DATA_DIR}/}"
    user="${rel%%/*}"
    user_sanitized="${user// /_}"
    out_name="$(ts_utc)__${user_sanitized}__upload__${base}"
    dest="$AUDIT_DIR/$out_name"
    if ! cp --reflink=auto -- "$PATH_CHANGED" "$dest" 2>/dev/null; then
      cp -- "$PATH_CHANGED" "$dest"
    fi
    chown "$WEB_USER:$WEB_USER" "$dest"
    scan_admin_audit "$out_name"
    echo "[upload-mirror] $PATH_CHANGED -> $dest"
  fi
  done
EOF

  # ---- download mirror ----
  cat >/usr/local/bin/nc_audit_download_mirror.sh <<'EOF'
#!/usr/bin/env bash
set -Eeuo pipefail

# === 依你的環境調整（很重要） ===
NC_ROOT="/var/www/PStorage.ntuee.temp"
DATA_DIR="/var/www/PStorage.ntuee.temp/data"
OCC="$NC_ROOT/occ"
AUDIT_DIR="$DATA_DIR/admin/files/audit"
WEB_USER="www-data"
LOG_FILE="/var/log/apache2/PStorage.ntuee.temp_access.log"

DEBUG=1

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

tail -F "$LOG_FILE" | \
grep -E --line-buffered 'GET .*(/index\.php/)?remote\.php/dav/files/' | \
while IFS= read -r line; do
  url_path_enc="$(perl -ne 'print "$1\n" if m{GET\s+(\S*remote\.php/dav/files/\S*)}i' <<<"$line")"
  [[ -n "${url_path_enc:-}" ]] || { logd "no url extracted"; continue; }
  url_path_enc="${url_path_enc#/index.php/}"
  [[ "$url_path_enc" == /remote.php/dav/files/* ]] || { logd "skip non-webdav: $url_path_enc"; continue; }
  rest_enc="${url_path_enc#/remote.php/dav/files/}"
  [[ -n "$rest_enc" ]] || { logd "empty rest_enc"; continue; }
  rest_dec="$(url_decode "$rest_enc")"
  [[ -n "$rest_dec" ]] || { logd "empty rest_dec"; continue; }
  user="${rest_dec%%/*}"
  rel_path="${rest_dec#*/}"
  [[ -n "$user" && -n "$rel_path" && "$rel_path" != "$rest_dec" ]] || { logd "bad split: $rest_dec"; continue; }
  src="$DATA_DIR/$user/files/$rel_path"
  if [[ ! -f "$src" ]]; then
    logd "not a regular file: $src"; continue
  fi
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
EOF

  chmod 700 /usr/local/bin/nc_audit_upload_mirror.sh /usr/local/bin/nc_audit_download_mirror.sh
  chown root:root /usr/local/bin/nc_audit_upload_mirror.sh /usr/local/bin/nc_audit_download_mirror.sh
}

install_services() {
  cat >/etc/systemd/system/nc-audit-upload.service <<EOF
[Unit]
Description=Nextcloud audit upload mirror (inotify)
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/nc_audit_upload_mirror.sh
Restart=always
RestartSec=2
User=root

[Install]
WantedBy=multi-user.target
EOF

  cat >/etc/systemd/system/nc-audit-download.service <<EOF
[Unit]
Description=Nextcloud audit download mirror (access log tail)
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/nc_audit_download_mirror.sh
Restart=always
RestartSec=2
User=root

[Install]
WantedBy=multi-user.target
EOF

  systemctl daemon-reload
  systemctl enable --now nc-audit-upload.service
  systemctl enable --now nc-audit-download.service
}

post_check() {
  [[ -f "$LOG_FILE" ]] || echo "⚠ 提醒：找不到 LOG_FILE=$LOG_FILE，請確認 vhost 的 access log 路徑。"
  systemctl --no-pager --full status nc-audit-upload.service || true
  systemctl --no-pager --full status nc-audit-download.service || true
  echo
  echo "✔ 安裝完成。若要修改路徑或 LOG_FILE：編輯本檔案開頭變數，或直接改兩支腳本後重啟服務。"
  echo "  重啟：systemctl restart nc-audit-upload.service nc-audit-download.service"
  echo "  追日誌：journalctl -u nc-audit-upload.service -f"
  echo "          journalctl -u nc-audit-download.service -f"
}

main() {
  require_root
  install_deps
  create_audit_dir
  install_scripts
  install_services
  post_check
}
main "$@"
