echo -e "\e[33m Copy Dispatch Service\e[0m"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[33m Install Golang\e[0m"
dnf install golang -y

echo -e "\e[33m Add application user\e[0m"
useradd roboshop

echo -e "\e[33m Create application directory\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[33m Download application content\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

echo -e "\e[33m Extract application content\e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[33m Download application dependencies\e[0m"
go mod init dispatch
go get
go build

echo -e "\e[33m Start applicaion service\e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch