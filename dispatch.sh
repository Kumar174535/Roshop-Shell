source common.sh
app_name=dispatch

if [ -z "$1" ]; then
  echo input rabbitmq password is missing
  eixt 1
fi

rabbitmq_password=$1
print_heading "Copy Dispatch Service"
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
echo $?

goland_setup