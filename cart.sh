source common.sh
app_name=cart

print_heading "Copy Cart Service"
cp cart.service /etc/systemd/system/cart.service &>>$log_file
echo $?

print_heading "Install nodejs"
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:20 -y &>>$log_file
dnf install nodejs -y &>>$log_file
echo $?

#function_name
app_prerequisites

print_heading "Creating application dependencies"
cd /app &>>$log_file
npm install &>>$log_file
echo $?

print_heading "system service restarts"
service_start
