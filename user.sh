source common.sh
app_name=user

print_heading "copy user service"
cp user.service /etc/systemd/system/user.service &>>$log_file
echo $?

print_heading "install nodejs"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:20 -y &>>$log_file
dnf install nodejs -y &>>$log_file
echo $?

#function_name
app_prerequisites

print_heading "install dependencies"
npm install &>>$log_file
echo $?

print_heading "system services started"
service_start
echo $?

