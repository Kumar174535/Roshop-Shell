cp nginx.conf /etc/nginx/nginx.conf
cp mongodb.repo /etc/yum.repos.d/mongo.repo

#list modules
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y


#remove the default content
rm -rf /usr/share/nginx/html/*

#download the frontend content
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

#extract the frontend content
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

#restart service
systemctl restart nginx
systemctl enable nginx