#!/bin/bash

# [1] Download source code
# [1-a] Download source file form github
sudo apt install git -y && \
echo "[INFO] Downloading pstorage source code..."
git clone https://github.com/nisson2000/P-Storage && \
# [1-b] Move the source file to the execution directory and setup permissions
mv P-Storage PStorage.ntuee.temp && \
sudo chown www-data:www-data -R PStorage.ntuee.temp/ && \
sudo mv PStorage.ntuee.temp /var/www/ && \
echo "[INFO] pstorage downloaded and configured successfully!"

# [2] Config apache server
# [2-a] Disable the default config file
echo "[INFO] Configuring apache..."
sudo a2dissite 000-default && \
# [2-b] Create a new config file for pstorage
sudo tee /etc/apache2/sites-available/PStorage.ntuee.temp.conf > /dev/null <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/PStorage.ntuee.temp"
    ServerName PStorage.ntuee.temp

    <Directory "/var/www/PStorage.ntuee.temp/">
        Options MultiViews FollowSymlinks
        AllowOverride ALL
        Order allow,deny
        Allow from all
    </Directory>

    TransferLog /var/log/apache2/PStorage.ntuee.temp_access.log
    ErrorLog /var/log/apache2/PStorage.ntuee.temp_error.log

</VirtualHost>
EOF
# [2-c] Enable the new config file
sudo a2ensite PStorage.ntuee.temp.conf && \
echo "[INFO] apache configured successfully!"

# [3] Config the php
# [3-a] Open the related file
echo "[INFO] Configuring php..."
sudo nano /etc/php/8.3/apache2/php.ini && \
# [3-b] Manual edit the para below
# use 'ctrl+w' to search keywords and modify
# memory_limit = 512M / 1024M
# upload_max_filesize = 200M / 100G
# max_execution_time = 360 / 3600
# post_max_size = 200M / 100G
# date.timezone = Asia/Taipei
# opcache.enable = 1
# opcache.memory_consumption = 128 / 256
# opcache.interned_strings_buffer = 8 / 16
# opcache.max_accelerated_files = 10000 /20000
# opcache.revalidate_freq = 1 / 60
# opcache.save_comments = 1
echo "[INFO] php configured successfully!"

# [4] Restart apache and enable new setup
echo "[INFO] Restarting apache..."
sudo a2enmod dir env headers mime rewrite ssl && \
sudo systemctl restart apache2 && \
echo "[INFO] apache restarted successfully!"

# [5] Login the pstorage using the default credential below to check validity
# usr/pwd == admin/PStorage
