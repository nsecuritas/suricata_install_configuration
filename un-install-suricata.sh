#!/bin/sh
      
temp_line () {
var=1
while [ $var -le 50 ]
do
printf "="
var=`expr $var + 1`
done
printf "\n"
}
   
        temp_line
	echo "|               ~~~SURICATA-UN-INSTALL~~~        |"
	temp_line
        read -p "Make sure you are in Suricata directory (y/n) : " sure
        if [ "$sure" = "n" ]
        then
                echo "Please move into Suricata Source  Directory and try again.."
sleep 5
        	exit
        fi
        temp_line
	echo "| 1.Un-install Completely(Recomended)            |\n| 2.Un-install Partially(config only)            |"
        temp_line
	read -p "Choose from above option : " option
	case $option in
	1) read -p "Provide root password: " pass
	echo $pass|sudo -S make uninstall
	if [ $? -eq 0 ] 
	then
		echo "1.All of the  Dependency Library Remove : Successful."
sleep 5
	else
		echo "1.Something went wrong..Please try remove again.."
	exit
	fi

       # rm -rf suricata-$VER
        sudo rm -rf /etc/suricata
        if [ $? -eq 0 ] 
	then
        	echo "Removing all configuration fileS : Successfull"
sleep 5
	else
       	echo "Removing all configuration files : Failed" 
	fi 
        read -p "Preserve the log file(y/n) : " ans
        if [ "$ans" = "y" ]
        then
	       sudo tar cvzf ~/suricata_bkp.tar.gz -C /var/log/suricata/*
               if [ $? -eq 0 ]
               then
               		echo "Creating log backup : Successful"
sleep 5
               else
               		echo "Creating log backup : Failed "
               		read -p "Still want to uninstall (y/n) : " choice
               		if [ "$choice" = "y" ]
               		then
               			break
               		else
               			exit
               		fi
               fi
        fi
	        sudo rm -rf /var/log/suricata
		
       ;;
       2) echo "nothing to do now .."
       ;;
       *) echo "Invalid choice.."
       exit
       ;;
       esac
