source common.sh
app_name=mongod

print_heading "Copy mongodb repo file"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
status_check $? #exit status

print_heading "install mongodb"
dnf install mongodb-org -y &>>$log_file
status_check $?

print_heading "update mongodb listen address"
sed -ie 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log_file
status_check $?

print_heading "system service started"
service_no_daemon
status_check $?