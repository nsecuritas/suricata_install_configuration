#!/bin/sh


ps -eLf|grep -w "/usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0 --init-errors-fatal"|grep -v "grep" >>/dev/null
if [ $? -eq 0 ]
then

id=`ps -eLf|grep -w "/usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0 --init-errors-fatal"|grep -v "sudo /usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0 --init-errors-fatal"|head -n 1|awk '{printf $2}'` 
echo $id
if [ $? -eq 0 ]
then
echo "Shutting down the Engine.."
sudo kill -9 $id 
fi
else
echo "Not able to stop or Engine not runnig currently.."
exit
fi
