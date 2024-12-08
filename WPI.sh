#!/bin/bash

# 更新软件包列表
apt update

# 安装 Apache、PHP、MariaDB
apt install apache2 php libapache2-mod-php mariadb-server -y

# 配置 MariaDB
mysql_secure_installation

# 创建 WordPress 数据库
read -p "请输入数据库名: " DB_NAME
read -p "请输入数据库用户名: " DB_USER
read -p "请输入数据库用户密码: " DB_PASSWORD
mysql -e "CREATE DATABASE $DB_NAME;"
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"

# 下载 WordPress 安装包
wget https://wordpress.org/latest.zip

# 解压安装包
unzip latest.zip -d /var/www/html

# 配置 Apache
a2enmod rewrite
systemctl restart apache2

# 访问 http://你的域名/ 完成 WordPress 安装