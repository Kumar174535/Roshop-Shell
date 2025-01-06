source common.sh
app_name=dispatch

print_heading "Copy Dispatch Service"
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
echo $?

goland_setup