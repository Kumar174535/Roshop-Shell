source common.sh
app_name=rabbitmq-server

print_heading "Coppy rabbitmq"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$log_file #redirecting output to log file
status_check $? #exit status

print_heading "install rabbitmq"
dnf install rabbitmq-server -y &>>$log_file
status_check $?

print_heading "Add application user"
rabbitmqctl add_user roboshop roboshop123 &>>$log_file
status_check $?

print_heading "Set permissions"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
status_check $?

print_heading "start system services"
service_no_daemon
status_check $?


