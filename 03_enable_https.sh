#!/bin/bash

# [1] Gen a self-signed certificate
sudo openssl req -newkey rsa:2048 -nodes -keyout pstorage.key -out pstorage.csr && \
sudo openssl x509 -req -days 3650 -in pstorage.csr -signkey pstorage.key -out pstorage.crt && \
mv pstorage.crt /etc/ssl/certs/pstorage.crt && \
mv pstorage.key /etc/ssl/private/pstorage.key && \

# [2] Edit conf as follows
sudo nano /etc/apache2/sites-available/PStorage.ntuee.temp.conf && \
#<VirtualHost *:3000>
#    DocumentRoot "/var/www/PStorage.ntuee.temp"
#    ServerName PStorage.ntuee.temp
#
#    SSLEngine on
#    SSLCertificateFile /etc/ssl/certs/pstorage.crt
#    SSLCertificateKeyFile /etc/ssl/private/pstorage.key
#    <Directory "/var/www/PStorage.ntuee.temp/">
#        Options MultiViews FollowSymlinks
#        AllowOverride ALL
#        Order allow,deny
#        Allow from all
#    </Directory>
#
#    TransferLog /var/log/apache2/PStorage.ntuee.temp_access.log
#    ErrorLog /var/log/apache2/PStorage.ntuee.temp_error.log
#
#</VirtualHost>

# [3] Edit ports listening as follows
sudo nano /etc/apache2/ports.conf && \
# Listen 3000

# [4] restart and reload apache2
sudo a2enmod ssl && \
sudo systemctl reload apache2 && \
sudo systemctl restart apache2
