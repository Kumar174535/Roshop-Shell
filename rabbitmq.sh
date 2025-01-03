source common.sh
app_name=rabbitmq-server

print_heading "Coppying rabbitmq"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$log_file #redirecting output to log file
echo $? #exit status

print_heading "installing rabbitmq"
dnf install rabbitmq-server -y &>>$log_file
rabbitmqctl add_user roboshop roboshop123 &>>$log_file
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
echo $?

print_heading "system services started"
service_no_daemon
echo $?


