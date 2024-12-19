source common.sh
app_name=dispatch

echo -e "$color Copy Dispatch Service $no_color"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "$color Install Golang $no_color"
dnf install golang -y

#function name
app_prerequisites

echo -e "$color Download application dependencies $no_color"
go mod init dispatch
go get
go build

echo -e "$color Start applicaion service $no_color"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch