source common.sh
app_name=frontend

print_heading "Copy Nginx and mongodb server"
cp nginx.conf /etc/nginx/nginx.conf &>>$log_file
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log_file
status_check $? #exit status

print_heading "disable default nginx server"
dnf module disable nginx -y &>>$log_file
status_check $?

print_heading "Enable nginx 24 version"
dnf module enable nginx:1.24 -y &>>$log_file
status_check $?

print_heading "Install nginx"
dnf install nginx -y &>>$log_file
status_check $?

print_heading "clean up old frontend content"
rm -rf /usr/share/nginx/html/* &>>$log_file
status_check $?

print_heading "Download frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$log_file
status_check $?

print_heading "extract the frontend content"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
status_check $?

print_heading "start system services"
service_no_daemon
status_check $?