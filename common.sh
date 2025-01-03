color="\e[36m"
no_color="\e[0m"
rm -f /tmp/roboshop.log
log_file=/tmp/roboshop.log


app_prerequisites() {
  print_heading "Add application user"
  id roboshop &>>$log_file
  if [ $? -ne 0 ]; then
    useradd roboshop &>>$log_file
  fi
  echo $?

  print_heading "Creating application directory"
  rm -rf /app &>>$log_file
  mkdir /app
  echo $?

  print_heading "downloading content"
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  cd /app
  echo $?

  print_heading "extract content"
  unzip /tmp/$app_name.zip &>>$log_file
  cd /app
  echo $?

}

print_heading() {
  echo -e "$color $1 $no_color"  &>>$log_file
  echo -e "$color $1 $no_color"
}

service_start() {
  systemctl daemon-reload &>>$log_file
  systemctl enable $app_name &>>$log_file
  systemctl restart $app_name &>>$log_file
}

service_no_daemon() {
  systemctl enable $app_name &>>$log_file
  systemctl restart $app_name &>>$log_file
}

status_check() {
  if [ $1 -ne 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[31m FAILURE \e[0m"
  fi


}