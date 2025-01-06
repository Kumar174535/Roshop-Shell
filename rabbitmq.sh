source common.sh
app_name=rabbitmq-server

if [ -z "$1" ]; then
  echo input rabbitmq root password is missing
fi

rabbitmq_root_password=$1

print_heading "Coppy rabbitmq"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$log_file #redirecting output to log file
status_check $? #exit status

print_heading "install rabbitmq"
dnf install rabbitmq-server -y &>>$log_file
status_check $?

print_heading "Add application user"
rabbitmqctl add_user roboshop $rabbitmq_root_password &>>$log_file
status_check $?

print_heading "Set permissions"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
status_check $?

print_heading "start system services"
service_no_daemon
status_check $?


