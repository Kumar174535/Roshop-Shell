color="\e[36m"
no_color="\e[0m"

app_prerequisites(){
  echo -e "$color Add application user $no_color"
  useradd roboshop

  echo -e "$color Creating application directory $no_color"
  rm -rf /app
  mkdir /app

  echo -e "$color downloading content $no_color"
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
  cd /app

  echo -e "$color extract content $no_color"
  unzip /tmp/$app_name.zip
  cd /app

}