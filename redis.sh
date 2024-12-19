source common.sh

echo -e "$color installing redis $no_color"
dnf module disable redis -y
dnf module enable redis:7 -y
dnf install redis -y

echo -e "$color changing ip address to 0.0.0.0 $no_color"
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf

echo -e "$color system services started $no_color"
systemctl enable redis
systemctl restart redis

