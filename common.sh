color="\e[36m"
no_color="\e[0m"
log_file=/tmp/roboshop.log
rm -f /tmp/roboshop.log
scripts_path=$(pwd) #command substitution

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

systemd_setup() {
  print_heading "Copy" $app_name "Service File"
  cp $scripts_path/$app_name.service /etc/systemd/system/$app_name.service &>>$log_file
  sed -i -e "s/rabbitmq_password/${rabbitmq_password}/" /etc/systemd/system/$app_name.service &>>$log_file
  status_check $?

  print_heading "system service started"
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

maven_setup() {
  print_heading "install maven"
  dnf install maven -y &>>$log_file
  status_check $?

  app_prerequisites

  print_heading "Cleaning Application Dependencies"
  mvn clean package &>>$log_file
  mv target/$app_name-1.0.jar $app_name.jar &>>$log_file
  status_check $?

  print_heading "install MYSQL Client"
  dnf install mysql -y &>>$log_file &>>$log_file
  status_check $?

  for mysql_file in schema app-user master-data; do
    print_heading "load SQL file"
    mysql -h mysql.devops24.shop -uroot -p$mysql_root_password < /app/db/$mysql_file.sql &>>$log_file
  done
  status_check $?

  systemd_setup
}

python_setup() {
  print_heading "Install python3"
  dnf install python3 gcc python3-devel -y &>>$log_file
  status_check $?

  #function_name
  app_prerequisites

  print_heading "Download application dependencies"
  pip3 install -r requirements.txt &>>$log_file
  status_check $?

  systemd_setup
}

nodejs_setup() {
  print_heading "Disable default nodejs"
  dnf module disable nodejs -y &>>$log_file
  status_check $?

  print_heading "Enable nodejs 20 version"
  dnf module enable nodejs:20 -y &>>$log_file
  status_check $?

  print_heading "Install nodejs"
  dnf install nodejs -y &>>$log_file
  status_check $?

  app_prerequisites

  print_heading "install dependencies"
  npm install &>>$log_file
  status_check $?

  systemd_setup
}

golang_setup() {
  print_heading "Install Golang"
  dnf install golang -y &>>$log_file
  echo $?

  #function name
  app_prerequisites

  print_heading "Download application dependencies"
  go mod init dispatch &>>$log_file
  go get &>>$log_file
  go build &>>$log_file
  echo $?

  print_heading "Start system service"
  service_start
  echo $?
}