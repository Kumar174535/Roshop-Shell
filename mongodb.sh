source common.sh

echo -e "$color Copying mongodb $no_color"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "$color installing mongodb $no_color"
dnf install mongodb-org -y

echo -e "$color Setting ip address to 0.0.0.0 $no_color"
sed -ie 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "$color system service started $no_color"
systemctl restart mongod
systemctl enable mongod