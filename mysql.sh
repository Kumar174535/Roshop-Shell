source common.sh
app_name=mysql

if [ -z "$1" ];then
  echo input mysql root password is missing
  exit 1
fi

mysql_root_password=$1

print_heading "Install mysql server"
dnf install mysql-server -y &>>$log_file
status_check $? #exit status

print_heading "start system services"
service_no_daemon
status_check $?

print_heading "setup mysql password"
mysql_secure_installation --set-root-pass $mysql_root_password &>>$log_file
status_check $?