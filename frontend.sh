source common.sh
app_name=frontend

print_heading "Copy Nginx and mongodb server"
cp nginx.conf /etc/nginx/nginx.conf &>>$log_file
cp mongodb.repo /etc/yum.repos.d/mongo.repo &>>$log_file
echo $? #exit status

print_heading "installing nginx server"
dnf module disable nginx -y &>>$log_file
dnf module enable nginx:1.24 -y &>>$log_file
dnf install nginx -y &>>$log_file
echo $?

print_heading "remove the default content"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

print_heading "Downloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>>$log_file
echo $?

print_heading "extract the frontend content"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
echo $?

print_heading "system started services"
service_no_daemon
echo $?