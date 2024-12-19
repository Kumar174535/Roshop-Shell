source common.sh
app_name=payment

echo -e "$color Copy Payment Service $no_color"
cp payment.service /etc/systemd/system/payment.service

echo -e "$color Install python3 $no_color"
dnf install python3 gcc python3-devel -y

app_prerequisites
echo -e "$color installing dependencies $no_color"
pip3 install -r requirements.txt

echo -e "$color restarting services $no_color"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment

