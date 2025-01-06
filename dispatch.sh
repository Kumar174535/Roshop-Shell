source common.sh
app_name=dispatch

print_heading "Copy Dispatch Service"
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
echo $?

print_heading "Install Golang"
dnf install golang -y &>>$log_file
echo $?

#function name
app_prerequisites

print_heading "Download application dependencies"
go mod init dispatch &>>$log_file
go get &>>$log_file
go build &>>$log_file
echo $?

print_heading "Start system service"
service_start
echo $?