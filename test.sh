#!/bin/sh
temp_line () {
var=0
while [ $var -le 60 ]
do
printf "-"
var=`expr $var + 1`
done
printf "\n"
}


temp_line
echo "~~~SURICATA~~~"
temp_line
echo " 1. Install Suricata\n 2. Un-install Suricata \n"
temp_line
read -p "Choose from the option : " opt
case $opt in
1)
	##library
	## TO do -Find the version of the library files.
	read -p "password: " pass
	echo $pass|sudo -S apt-get -y install libpcre3 libpcre3-dbg libpcre3-dev \
	build-essential autoconf automake libtool libpcap-dev libnet1-dev \
	libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libcap-ng-dev libcap-ng0 \
	make libmagic-dev libjansson-dev libjansson4 pkg-config  
	if [ $? -eq 0 ] 
	then
		echo "All of the  Dependency Library Installtion : Successful."
sleep 5
	else
		echo "Something went wrong..Please try download and install again.."
	exit
	fi
		
	##library
	## To do -Find the version of the library file.
	sudo apt-get -y install libnetfilter-queue-dev libnetfilter-queue1 libnfnetlink-dev libnfnetlink0
	if [ $? -eq 0 ] 
	then
		echo "All of the  Dependency Library Installtion : Successful."
sleep 5
	else
		echo "Something went wrong..Please try download and install again.."
	exit
	fi
	
		
	temp_line
	echo "Suricaata Compatible Versions"
	temp_line
	echo " 1. suricata-3.2.3 (old_stable)\n 2. Suricata-4.0.0 (New_stable)\n 3. Suricata-3.1"
	temp_line
	read -p " choose which version to be downloaded : " VER
	temp_line
	case $VER in
	1) VER=3.2.3 ;;
	2) VER=4.0.0 ;;
	3) VER=3.1 ;;
	*) echo "Not a Valid selection : " 
	exit ;;
	esac
	## To do-Fetch all the version and program will ask the  user to download the latest updated version(or as per the requirement.
	##VER=3.1
	read -p "Please specify the path for downloading suricata : " path
     	cd $path
	if [ $? -eq 0 ]
	then
       	echo " Changing Directory to $path : Successfull"
sleep 5
	else
       	echo "Changing Director to path $path: Failed"
	exit
	fi
	
	wget "http://www.openinfosecfoundation.org/download/suricata-$VER.tar.gz" 
	if [ $? -eq 0 ]
	then
        	echo "suricata-$VER downloaded in path $path: Successfull"
sleep 5
	else
        	echo "suricata-$VER downloaded in path $path: Failed"
                exit
	fi
		
       	tar -xvzf "suricata-$VER.tar.gz" 
	if [ $? -eq 0 ]
	then
        	echo "Extracting Components from suricata-$VER : Successfull"
sleep 5
	else
        	echo "Extracting Components from suricata-$VER : Failed"
                exit
	fi
	
	cd $path/suricata-$VER
	##
	temp_line
        	echo " 1.IDS(Default)\n 2.IDS/IPS(Advance)\n"
	temp_line
        	read -p "Enter the Security Mode : " mode
	case $mode in
	1) ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var 
	if [ $? -eq 0 ]
	then
        	echo "Configuration IDS mode : Successfull"
sleep 5
	else
        	echo "Configuration IDS mode : Failed"
                exit
	fi ;;
	2) ./configure --enable-nfqueue --prefix=/usr --sysconfdir=/etc --localstatedir=/var 
	if [ $? -eq 0 ]
	then
        	echo "Configuration IDS/IPS mode : Successfull"
sleep 5
	else
        	echo "Configuration IDS/IPS mode : Failed"
                exit
	fi ;;
	3) echo "Invalid Selection..Exiting.."
	   exit ;;
	esac




	make
		if [ $? -eq 0 ]
		then
	        	echo "Compilation : Successfull"
sleep 5
		else
	        	echo "Compilation : Failed"
                        exit
		fi 
		
	sudo make install-full 
		##sudo make install-conf
		##make install-rules
		##
	sudo ldconfig >>/dev/null
		if [ $? -eq 0 ] 
		then
	        	echo "Creating necessary links : Successfull"
sleep 5
		else
	        	echo "Creating necessary links : Failed" 
                        exit
		fi
		
	sudo mkdir /var/log/suricata 
		if [ $? -eq 0 ] 
		then
	        	echo "Directory Created : Successfull"
sleep 5
		else
	        	echo "Directory Created : Failed" 
		fi
		
	sudo mkdir /etc/suricata
		if [ $? -eq 0 ]
		then 
	        	echo "Directory Created : Successfull"
sleep 5
		else 
	        	echo "Directory Created : Failed"
		fi
		
	sudo cp classification.config /etc/suricata
		if [ $? -eq 0 ]
		then 
	        	echo "Copying file classification.config : Successfull"
sleep 5
		else 
	        	echo "Copying file classification.config : Failed"
		fi
	sudo cp reference.config /etc/suricata 
		if [ $? -eq 0 ]
		then 
	        	echo "Copying file reference.config : Successfull"
sleep 5
		else
	        	echo "Copying file reference.config : Failed"
		fi
		
	sudo cp suricata.yaml /etc/suricata 
		if [ $? -eq 0 ]
		then 
         		echo "Copying file suricata.yaml : Successfull"
sleep 5
		else
	        	echo "Copying file suricata.yaml : Failed"
		fi
		
	sudo cp -r rules/* /etc/suricata/rules/
		if [ $? -eq 0 ]
	       	then 
	        	echo "Copying rules to /etc/suricata/rules/ : Successfull"
sleep 5
		else
	        	echo "Copying rules to /etc/suricata/rules/ : Failed"
		fi 
		;;


2)      temp_line
	echo "               ~~~SURICATA_Un-install~~~          "
	temp_line
        read -p "Make sure you are in Suricata directory (y/n) : " sure
        if [ "$sure" = "n" ]
        then
                echo "Please move into Suricata Source  Directory and try again.."
sleep 5
        	exit
        fi
	echo " 1.Un-install Completely(Recomended)\n 2.Un-install Partially(config only)"
	read -p "Choose from above option : " option
	case $option in
	1) read -p "password: " pass
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
esac
