source common.sh
app_name=catalogue

print_heading "Copy Mongodb repo file"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>$log_file
status_check $?

nodejs_setup

print_heading "Install mongodb client"
dnf install mongodb-mongosh -y &>>$log_file
status_check $?

print_heading "load master data"
mongosh --host mongodb.devops24.shop </app/db/master-data.js &>>$log_file
status_check $?

print_heading "Restart catalogue service"
systemctl restart $app_name &>>$log_file
status_check $?

