source common.sh

print_heading "Copying Mongodb repo file"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>log_file
echo $?

print_heading "Copying catalogue service file"
cp catalogue.service /etc/systemd/system/catalogue.service &>>log_file
echo $? #exit status

print_heading "Installing nodejs"
dnf module disable nodejs -y &>>log_file
dnf module enable nodejs:20 -y &>>log_file
dnf install nodejs -y &>>log_file
echo $?

app_prerequisites

print_heading "install dependencies"
npm install &>>log_file
echo $?

print_heading "Installing mongodb"
dnf install mongodb-mongosh -y &>>log_file
mongosh --host mongodb.devops24.shop </app/db/master-data.js &>>log_file
echo $?

print_heading "services start"
systemctl daemon-reload &>>log_file
systemctl enable catalogue &>>log_file
systemctl restart catalogue &>>log_file
