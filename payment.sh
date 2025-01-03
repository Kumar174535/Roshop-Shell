source common.sh
app_name=payment


print_heading "Copy Payment Service"
cp payment.service /etc/systemd/system/payment.service &>>$log_file
status_check $?

print_heading "Install python3"
dnf install python3 gcc python3-devel -y &>>$log_file
status_check $?

#function_name
app_prerequisites

print_heading "installing dependencies"
pip3 install -r requirements.txt &>>$log_file
status_check $?

print_heading "restarting services"
service_start
status_check $?

