source common.sh

print_heading "Installing mysql server"
dnf install mysql-server -y &>>log_file
echo $? #exit status

print_heading "system started services"
systemctl enable mysqld &>>log_file
systemctl restart mysqld &>>log_file
mysql_secure_installation --set-root-pass RoboShop@1 &>>log_file
echo $?