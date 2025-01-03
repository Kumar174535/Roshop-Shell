source common.sh
app_name=shipping

print_heading "copying shipping service file"
cp shipping.service /etc/systemd/system/shipping.service &>>$log_file #sending output to log file
echo $? #exit status

print_heading "installing maven"
dnf install maven -y &>>$log_file
echo $?

app_prerequisites

print_heading "Cleaning maven package"
mvn clean package &>>$log_file
mv target/shipping-1.0.jar shipping.jar &>>$log_file
echo $?

print_heading "installing mysql"
dnf install mysql -y &>>$log_file
mysql -h mysql.devops24.shop -uroot -pRoboShop@1 < /app/db/schema.sql &>>$log_file
mysql -h mysql.devops24.shop -uroot -pRoboShop@1 < /app/db/app-user.sql &>>$log_file
mysql -h mysql.devops24.shop -uroot -pRoboShop@1 < /app/db/master-data.sql &>>$log_file
echo $?

print_heading "system service start"
service_start
echo $?