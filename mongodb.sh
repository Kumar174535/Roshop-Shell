cp mongodb.repo /etc/yum.repos.d/mongodb.repo

dnf install mongodb-org -y

sed -ie 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf


systemctl restart mongod
systemctl enable mongod