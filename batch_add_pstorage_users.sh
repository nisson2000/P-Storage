#!/usr/bin/env bash
# batch_add_pstorage_users.sh
# 讀取 CSV：username,password[,displayName]
# 逐筆呼叫 add_pstorage_user_and_share.sh 建帳 → 建 internal/external → 分享給 admin → admin 視圖改名/歸檔
set -Eeuo pipefail

# === 依環境調整（若 add_pstorage_user_and_share.sh 不在同資料夾，請改路徑） ===
THIS_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SINGLE_SCRIPT="$THIS_DIR/add_pstorage_user_and_share.sh"

# === 參數 ===
CSV=""
ADMIN_PASS=""
INSECURE=0
STOP_ON_ERROR=0    # 0：遇錯繼續；1：遇錯停止

usage() {
  cat <<EOF
用法：
  sudo bash $0 -f <users.csv> -A <adminPassword> [--insecure] [--stop-on-error]

參數：
  -f  CSV 路徑，格式：username,password[,displayName]
  -A  admin 的密碼（或 App Password），用於 admin 端改名/歸檔
  --insecure     自簽憑證測試時加入（傳給 curl 的 -k）
  --stop-on-error  遇到錯誤立即停止（預設遇錯繼續）

注意：
  本腳本會逐筆呼叫：
    $SINGLE_SCRIPT
EOF
}

[[ $EUID -eq 0 ]] || { echo "請以 root 執行（sudo）"; exit 1; }

while [[ $# -gt 0 ]]; do
  case "$1" in
    -f) CSV="$2"; shift 2;;
    -A) ADMIN_PASS="$2"; shift 2;;
    --insecure) INSECURE=1; shift;;
    --stop-on-error) STOP_ON_ERROR=1; shift;;
    -h|--help) usage; exit 0;;
    *) echo "未知參數：$1"; usage; exit 1;;
  esac
done

[[ -n "$CSV" && -n "$ADMIN_PASS" ]] || { usage; exit 1; }
[[ -f "$CSV" ]] || { echo "[ERR] 找不到 CSV：$CSV"; exit 1; }
[[ -x "$SINGLE_SCRIPT" ]] || { echo "[ERR] 找不到或不可執行：$SINGLE_SCRIPT"; exit 1; }

ok=0; fail=0
echo "== 批次建立開始：$(date -u +%FT%TZ)"
echo "   來源 CSV：$CSV"

# 逐行讀 CSV（跳過空行與 # 註解）
# 欄位：username,password[,displayName]
# 允許 displayName 留空
line_no=0
while IFS= read -r raw || [[ -n "$raw" ]]; do
  line_no=$((line_no+1))
  line="$(echo "$raw" | tr -d '\r')"        # 去除 CR（Windows CSV）
  [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

  IFS=',' read -r USER PASS DNAME <<<"$line"

  # 修剪空白
  USER="${USER:-}"; USER="${USER//[$'\t\r\n ']/}"
  PASS="${PASS:-}"; PASS="${PASS//$'\r'/}"
  DNAME="${DNAME:-}"

  if [[ -z "$USER" || -z "$PASS" ]]; then
    echo "[ERR][line $line_no] 格式錯誤，需至少 username,password：$raw"
    fail=$((fail+1))
    [[ "$STOP_ON_ERROR" = "1" ]] && exit 1
    continue
  fi

  echo "----"
  echo "[RUN] $USER …"
  set +e
  if [[ -n "$DNAME" ]]; then
    if [[ "$INSECURE" = "1" ]]; then
      sudo bash "$SINGLE_SCRIPT" -u "$USER" -p "$PASS" -n "$DNAME" -A "$ADMIN_PASS" --insecure
    else
      sudo bash "$SINGLE_SCRIPT" -u "$USER" -p "$PASS" -n "$DNAME" -A "$ADMIN_PASS"
    fi
  else
    if [[ "$INSECURE" = "1" ]]; then
      sudo bash "$SINGLE_SCRIPT" -u "$USER" -p "$PASS" -A "$ADMIN_PASS" --insecure
    else
      sudo bash "$SINGLE_SCRIPT" -u "$USER" -p "$PASS" -A "$ADMIN_PASS"
    fi
  fi
  rc=$?
  set -e

  if [[ $rc -eq 0 ]]; then
    echo "[OK] $USER 完成"
    ok=$((ok+1))
  else
    echo "[ERR] $USER 失敗（exit $rc）"
    fail=$((fail+1))
    [[ "$STOP_ON_ERROR" = "1" ]] && exit $rc
  fi
done < "$CSV"

echo "----"
echo "== 批次完成：OK=$ok, FAIL=$fail"
[[ "$fail" -eq 0 ]] || exit 1
