color="\e[36m"
no_color="\e[0m"
log_file=/tmp/roboshop.log
rm -f /tmp/roboshop.log

app_prerequisites(){
  echo -e "$color Add application user $no_color"
  useradd roboshop &>>$log_file
  echo $?

  echo -e "$color Creating application directory $no_color"
  rm -rf /app &>>$log_file
  mkdir /app
  echo $?

  echo -e "$color downloading content $no_color"
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>log_file
  cd /app
  echo $?

  echo -e "$color extract content $no_color"
  unzip /tmp/$app_name.zip &>>log_file
  cd /app
  echo $?

}