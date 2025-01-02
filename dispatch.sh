source common.sh
app_name=dispatch

echo -e "$color Copy Dispatch Service $no_color"
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
echo $?

echo -e "$color Install Golang $no_color"
dnf install golang -y &>>$log_file
echo $?

#function name
app_prerequisites

echo -e "$color Download application dependencies $no_color"
go mod init dispatch
go get
go build
echo $?

echo -e "$color Start applicaion service $no_color"
systemctl daemon-reload &>>log_file
systemctl enable dispatch &>>log_file
systemctl restart dispatch &>>log_file
echo $?