#!/bin/sh


ethernet_card=`ifconfig|head -n 1|cut -d ' ' -f1`
sudo /usr/bin/suricata -c /etc/suricata/suricata.yaml -i $ethernet_card --init-errors-fatal
if [ $? -ne 0 ]
then
echo "Something went wrong..can't start the Engine currently.Try again.."
exit
fi
