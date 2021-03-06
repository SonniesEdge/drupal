#!/usr/bin/env bash

apt-get update
apt-get -y install zsh htop vim ntp

# ufw enable
# ufw allow 22
# ufw allow 3306
# ufw allow 80

# Install Apache
apt-get -y install php7.0 libapache2-mod-php7.0


# Install MySQL
## Allow unattended install of MySQL
export DEBIAN_FRONTEND=noninteractive
MYSQL_ROOT_PASSWORD='root' 
export DEBIAN_FRONTEND="noninteractive"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

## Install MySQL
sudo apt-get install -y mysql-server mysql-client

## Create database
echo "create database sonniesedge" | mysql -uroot -proot

# Install PHP
apt-get -y install php7.0-mysql php7.0-curl php7.0-gd php7.0-intl php-pear php-imagick php7.0-imap php7.0-mcrypt php-memcache  php7.0-pspell php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xmlrpc php7.0-xsl php7.0-mbstring php-gettext

# Allow url rewriting in Apache
a2enmod rewrite

# Allow htaccess overrides in Apache
perl -0777 -i.original -pe 's/Options Indexes FollowSymLinks\n\tAllowOverride None/Options Indexes FollowSymLinks\n\tAllowOverride All/igs' /etc/apache2/apache2.conf

# Restart Apache 
systemctl restart apache2

apt-get install zip unzip git

# Install Drush
wget http://files.drush.org/drush.phar
chmod +x drush.phar
mv drush.phar /usr/local/bin/drush
