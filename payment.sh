color="\e[35m"
no_color="\e[0m"

echo -e "$color Copy Payment Service $no_color"
cp payment.service /etc/systemd/system/payment.service

echo -e "$color Install python3 $no_color"
dnf install python3 gcc python3-devel -y

echo -e "$color Add application user $no_color"
useradd roboshop

echo -e "$color Creating application directory $no_color"
rm -rf /app
mkdir /app

echo -e "$color downloading content $no_color"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app

echo -e "$color extract content $no_color"
unzip /tmp/payment.zip
cd /app

echo -e "$color installing dependencies $no_color"
pip3 install -r requirements.txt

echo -e "$color restarting services $no_color"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment

