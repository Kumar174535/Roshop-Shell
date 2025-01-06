source common.sh
app_name=shipping

if [ -z "$1" ];then
  echo input maven root password is missing
fi

maven_root_password=$1

maven_setup