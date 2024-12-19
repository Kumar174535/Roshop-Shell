source common.sh

echo -e "$color copy user service $no_color"
cp user.service /etc/systemd/system/user.service

echo -e "$color install nodejs $no_color"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

#function_name
app_prerequisites

echo -e "$install dependencies $no_color"
npm install

echo -e "$color system services started $no_color"
systemctl daemon-reload
systemctl enable user
systemctl restart user

