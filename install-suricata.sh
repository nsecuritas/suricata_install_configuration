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
	echo "|                ~~~SURICATA-INSTALL~~~          |"
	temp_line
 read -p "Provide root password: " pass
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
        echo "|          Suricata Compatible Versions          |"
        temp_line
        echo "| 1. suricata-3.2.3 (old_stable)                 |\n| 2. Suricata-4.0.0 (New_stable)                 |\n| 3. Suricata-3.1                                |"
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
        if [ "$path" = '' ]
        then
        path=~/
        fi
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
        echo "|           Security Mode                        |"    
        temp_line
                echo "| 1.IDS(Default)                                 |\n| 2.IDS/IPS(Advance)                             |"
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

