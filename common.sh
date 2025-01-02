color="\e[36m"
no_color="\e[0m"
log_file=/tmp/roboshop.log
rm -f /tmp/roboshop.log

app_prerequisites(){
  print_heading "Add application user"
  userdel roboshop
  useradd roboshop &>>$log_file
  echo $?

  print_heading "Creating application directory"
  rm -rf /app &>>$log_file
  mkdir /app
  echo $?

  print_heading "downloading content"
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>log_file
  cd /app
  echo $?

  print_heading "extract content"
  unzip /tmp/$app_name.zip &>>log_file
  cd /app
  echo $?

}

print_heading() {
  echo -e "$color $1 $no_color"  &>>/tmp/roboshop.log
  echo -e "$color $1 $no_color"
}

service_start(){
  systemctl daemon-reload &>>log_file
  systemctl enable $app_name &>>log_file
  systemctl restart $app_name &>>log_file
}