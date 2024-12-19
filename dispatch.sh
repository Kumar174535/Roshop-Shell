color="\e[35m"
no_color="\e[0m"

echo -e "$color Copy Dispatch Service $no_color"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "$color Install Golang $no_color"
dnf install golang -y

echo -e "$color Add application user $no_color"
useradd roboshop

echo -e "$color Create application directory $no_color"
rm -rf /app
mkdir /app

echo -e "$color Download application content $no_color"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

echo -e "$color Extract application content $no_color"
unzip /tmp/dispatch.zip

echo -e "$color Download application dependencies $no_color"
go mod init dispatch
go get
go build

echo -e "$color Start applicaion service $no_color"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch