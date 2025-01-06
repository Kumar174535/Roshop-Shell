source common.sh
app_name=mysql

print_heading "Install mysql server"
dnf install mysql-server -y &>>$log_file
status_check $? #exit status

print_heading "start system services"
service_no_daemon
status_check $?

print_heading "setup mysql password"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
status_check $?