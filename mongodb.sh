source common.sh
app_name=mongod

print_heading "Copying mongodb"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
echo $? #exit status

print_heading "installing mongodb"
dnf install mongodb-org -y &>>$log_file
echo $?

print_heading "setting ip address to 0"
sed -ie 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$log_file
echo $?

print_heading "system service started"
service_no_daemon
echo $?