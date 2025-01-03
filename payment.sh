source common.sh
app_name=payment


print_heading "Copy Payment Service"
cp payment.service /etc/systemd/system/payment.service &>>$log_file
echo $?

print_heading "Install python3"
dnf install python3 gcc python3-devel -y &>>$log_file
echo $?

#function_name
app_prerequisites

print_heading "installing dependencies"
pip3 install -r requirements.txt &>>$log_file
echo $?

print_heading "restarting services"
service_start
echo $?

