source common.sh

echo -e "$color Copy Nginx and mongodb server $no_color"
cp nginx.conf /etc/nginx/nginx.conf
cp mongodb.repo /etc/yum.repos.d/mongo.repo

echo -e "$color installing nginx server $no_color"
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

echo -e "$color remove the default content $no_color"
rm -rf /usr/share/nginx/html/*

echo -e "$color download the frontend content $no_color"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

echo -e "$color extract the frontend content $no_color"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "$color system started services $no_color"
systemctl restart nginx
systemctl enable nginx