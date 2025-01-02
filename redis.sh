source common.sh

print_heading "installing redis"
dnf module disable redis -y &>>log_file #sending output to log file
dnf module enable redis:7 -y &>>log_file
dnf install redis -y &>>log_file
echo $? #exit status

print_heading "changing ip_addr to 0"
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>log_file
echo $?

print_heading "system services started"
systemctl enable redis &>>log_file
systemctl restart redis &>>log_file
echo $?

