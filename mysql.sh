source common.sh
app_name=mysqld

print_heading "Installing mysql server"
dnf install mysql-server -y &>>$log_file
echo $? #exit status

print_heading "system started services"
service_no_daemon
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
echo $?