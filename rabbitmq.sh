source common.sh

echo -e "$color coppying rabbitmq $no_color"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo

echo -e "$color installing rabbitmq $no_color"
dnf install rabbitmq-server -y
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

echo -e "$color system services started $no_color"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server


