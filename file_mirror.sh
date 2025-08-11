#!bin/bash
LOG_FILE="/var/log/apache2/PStorage.ntuee.temp_access.log"
PSTORAGE_DATA="/var/www/PStorage.ntuee.temp/data"
BACKUP_DIR="/var/backups/PStorage_downloads"

mkdir -p "$BACKUP_DIR"
sudo tail -F "$LOG_FILE" | stdbuf -oL grep 'GET /remote.php/dav/files' | while read line; do
    if ! echo "$line" | grep -Eq 'attchment|Microsoft-Webdav-MiniRedir'; then
        continue
    fi
    FILE_PATH=$(echo "$line" | grep -oP '(?<=GET /remote.php/dav/files/)[^ ]+' | sed 's/%20/ /g')
    if [[ ! -z "$FILE_PATH"]];then
        USERNAME=${FILE_PATH%%/*}
        RELATIVE_PATH=${FILE_PATH#*/}
        FILE="$PSTORAGE_DATA/$USERNAME/files/$RELATIVE_PATH"
        if [[ -f ""$FILE" ]]; then
            TIMESTAMP=$(date +%Y%m%d%H%M%S)
            BACKUP_PATH="$BACK_DIR/${FILE_PATH//\//_}-$TIMESTAMP"
            cp "$FILE" "$BACKUP_PATH"
        fi
    fi
done
