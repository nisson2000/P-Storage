#!/usr/bin/env bash
set -Eeuo pipefail

# ===== 可調參數 =====
TARGET_DIR="${TARGET_DIR:-/data/backups}"  # 要清理的目錄
RETENTION_DAYS="${RETENTION_DAYS:-30}"     # 保留天數
DRY_RUN="${DRY_RUN:-1}"                    # 1=乾跑(只列出) 0=真的刪除

# ===== 內部處理 =====
cutoff_ts=$(date -d "-${RETENTION_DAYS} days" +%s)

log() { echo "[$(date '+%F %T')] $*"; }

if [[ ! -d "$TARGET_DIR" ]]; then
  log "目錄不存在：$TARGET_DIR"
  exit 1
fi

log "開始清理：DIR=$TARGET_DIR，保留 ${RETENTION_DAYS} 天內的檔案，DRY_RUN=$DRY_RUN"

shopt -s nullglob
deleted=0 listed=0 skipped=0

while IFS= read -r -d '' file; do
  base=$(basename "$file")

  # 抓最後一個 '-' 後的 14 位數字
  ts_str="${base##*-}"

  # 確認長度正確
  if [[ ! "$ts_str" =~ ^[0-9]{14}$ ]]; then
    ((skipped++))
    continue
  fi

  # 轉成 epoch
  ts_file=$(date -d "${ts_str:0:4}-${ts_str:4:2}-${ts_str:6:2} ${ts_str:8:2}:${ts_str:10:2}:${ts_str:12:2}" +%s 2>/dev/null) || {
    ((skipped++))
    continue
  }

  # 判斷是否過期
  if (( ts_file < cutoff_ts )); then
    if [[ "$DRY_RUN" -eq 1 ]]; then
      echo "[DRY] would delete: $file"
      ((listed++))
    else
      rm -f -- "$file" && ((deleted++)) || log "刪除失敗：$file"
    fi
  else
    ((skipped++))
  fi
done < <(find "$TARGET_DIR" -maxdepth 1 -type f -print0)

log "完成：listed=$listed deleted=$deleted skipped=$skipped cutoff=$(date -d "@$cutoff_ts" '+%F %T')"
