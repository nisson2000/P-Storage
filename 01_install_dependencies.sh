#!/bin/bash

# [1] Manually config the 'static IP' and 'Hostname'
# [1-a] Below are the related commands
# ip addr show
# sudo nano /etc/netplan/01-netcfg.yaml
########################################
# network:
#   version: 2
#   ethernets:
#     enp0s3:
#       dhcp4: no
#       addresses:
#         - 192.168.50.190/24
#       routes:
#         - to: default
#           via: 192.168.50.1
#       nameservers:
#         addresses:
#           - 8.8.8.8
########################################
# sudo netplan apply
# sudo chmod 600 /etc/netplan/01-network-manager-all.yaml
# sudo nano /etc/hosts
# sudo nano /etc/hostname
# [1-b] After that, reboot the system using the command below
# sudo apt update && sudo apt dist-upgrade
# sudo reboot

# [2] Install and config database (MariaDB)
# [2-a] Install DB
echo "[INFO] Installing MariaDB..."
sudo apt install mariadb-server -y && \
# [2-b] Check if the DB succefully installed, manual check can be done by the command below
# systemctl status mariadb
echo "[INFO] Checking MariaDB status..."
if systemctl is-active --quiet mariadb; then
  echo "[INFO] MariaDB is active and running."
else
  echo "[ERROR] MariaDB service is not active. Exiting."
  exit 1
fi
# [2-c] Config DB
echo "[INFO] Configuring MariaDB..."
sudo mysql_secure_installation && \
# press 'y' all the way down, and config new db admin and new pwd, by default pwd is "PStorage"
echo "[INFO] MariaDB is successfully configured"
# [2-d] Create a dedicated DB for pstorage
sudo mariadb && \
# interact with the command below
# CREATE DATABASE PStorage_db;
# SHOW DATABASES;
# GRANT ALL PRIVILEGES ON PStorage_db.* TO 'PStorage_db_admin'@'localhost' IDENTIFIED BY 'PStorage';
# FLUSH PRIVILEGES;
# 'ctrl+d' to leave
echo "[INFO] Dedicate DB for pstorage is successfully created"

# [3] Install PHP8.3 and Apache
# [3-a] Install
echo "[INFO] Installing PHP and Apache..."
sudo apt update && \
sudo apt install software-properties-common -y && \
sudo add-apt-repository ppa:ondrej/php -y && \
sudo apt update && \
sudo apt install php8.3 php8.3-apcu php8.3-bcmath php8.3-cli php8.3-common php8.3-curl php8.3-gd php8.3-gmp php8.3-imagick php8.3-intl php8.3-mbstring php8.3-mysql php8.3-zip php8.3-xml php8.3-fpm libapache2-mod-php8.3 apache2 -y && \
# [3-b] Check if the php version is right, manual check can be done by the command below
# php -v
php_version=$(php -v | head -n 1)
if echo "$php_version" | grep -q "PHP 8.3."; then
  echo "PHP version correct：$php_version"
else
  echo "PHP version incorrect：$php_version"
  exit 1
fi
# [3-c] Check if apache is well installed, manual check can be done by the command below
# systemctl status apache2
status=$(systemctl is-active apache2)
if [ "$status" = "active" ]; then
  echo "Apache2 is running"
else
  echo "Apache2 is not running (status: $status)"
  exit 1
fi
# [3-d] Install additional mod for php
sudo phpenmod bcmath gmp imagick intl && \
echo "[INFO] PHP and Apache successfully installed"

echo "[INFO] Dependencies are all successfully installed!! Script finished"