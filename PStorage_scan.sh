#!bin/bash
MONITIOR_DIR="/var/www/PStorage.ntuee.temp/data/admin/files/private folder"
PUBLIC_DIR="/var/www/PStorage.ntuee.temp/data/admin/files/public folder"
YARA_RULES="/usr/local/bin/keyword.yar"
LOGFILE="/var/log/apache2/PStorage.ntuee.temp_access.log"
OCC="/var/www/PStorage.ntuee.temp/occ"

inotifywait -m -e moved_to --format "%w%f" "MONITIOR_DIR" | while read FILE; do
    echo "$(date) inspect: $FILE" >> "$LOGFILE"
    YARAOUTPUT=$(yara -s "$YARA_RULES" "FILE")
    if [[ -n "YARAOUTPUT" ]]; then
        echo "anomalies detected : $YARAOUTPUT" >> "$LOGFILE"
        log_message=$(jq -n --compact-output \
        --arg reqId "$(head -c 16 /dev/urandom | base64 | tr -d '=+/' | cut -c1-20)" \
        --arg time "$(date --utc +%Y-%m-%dT%H:%M:%S%:z)" \
        --arg message "anomalies detected" \
        --arg app "YARA Scanner" \
        '{"reqId":$reqId,"level":2,"time":$time,"remoteAddr":127.0.0.1,"user":"-","app":$app,"method":"CLI","url":"-","message":$message,"userAgent":"Script","version":"28.0.1.14","data":[]}')
        echo "$log_message" >> "/var/www/PStorage.ntuee.temp/data/nextcloud.log"
    else
        FILENAME=$(basename "$FILE")
        if [[ "$FILENAME" == *.part ]]; then
            continue
        fi
        cp "$FILE" "$PUBLIC_DIR/$FILENAME"
        sudo chown www-data:www-data "$PUBLIC_DIR/$FILENAME"
        sudo -u www-data:www-data php "$OCC" files:scan --path="/admin/files/public folder"
    fi
done
