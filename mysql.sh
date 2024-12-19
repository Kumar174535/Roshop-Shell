source common.sh

echo -e "$color Installing mysql server $no_color"
dnf install mysql-server -y

echo -e "$color system started services $no_color"
systemctl enable mysqld
systemctl restart mysqld
mysql_secure_installation --set-root-pass RoboShop@1