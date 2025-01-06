source common.sh
app_name=payment

if [ -z "$1" ];then
  echo input rabbitmq password is missing
  exit 1
fi

rabbitmq_password=$1
python_setup

