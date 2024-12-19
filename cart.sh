source common.sh
app_name=cart

echo -e "$color Copy Cart Service $no_color"
cp cart.service /etc/systemd/system/cart.service

echo -e "$color Install nodejs $no_color"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

#function_name
app_prerequisites

echo -e "$color Creating application dependencies $no_color"
cd /app
npm install

echo -e "$color system service restarts $no_color"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart
