#!/bin/sh
temp_line () {
var=0
while [ $var -le 30 ]
do
printf "="
var=`expr $var + 1`
done
printf "\n"
}


temp_line
echo "|         ~~~SURICATA~~~      |"
temp_line
echo "| 1. Install                  |\n| 2. Un-install               |\n| 3. Start-up                 |\n| 4. Shutdown                 |"
temp_line
read -p "Choose from the option : " opt
case $opt in
1) ~/suricata_dir/install-suricata.sh
;;
2) ~/suricata_dir/un-install-suricata.sh     
;;
3) ~/suricata_dir/startup.sh
;;
4)  ~/suricata_dir/shutdown.sh
;;
esac
