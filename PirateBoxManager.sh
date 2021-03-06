#!/bin/bash                                                                                                   
# _|_|_|_|_|                                                  _|_|_|                _|                
#     _|      _|_|    _|  _|_|  _|  _|_|    _|_|    _|  _|_|  _|    _|  _|    _|  _|_|_|_|    _|_|    
#     _|    _|_|_|_|  _|_|      _|_|      _|    _|  _|_|      _|_|_|    _|    _|    _|      _|_|_|_|  
#     _|    _|        _|        _|        _|    _|  _|        _|    _|  _|    _|    _|      _|        
#     _|      _|_|_|  _|        _|          _|_|    _|        _|_|_|      _|_|_|      _|_|    _|_|_|  
#                                                                             _|                      
#                                                                         _|_|                        
# April 5 2012
#
# Simple script for starting a piratebox on a laptop (eeePC specifically)
#
# By Cale "TerrorByte" Black 
#
# Credit for the original piratebox goes to David Darts
#
# Credit for the wonderful scripts goes to Matthias Strubel
#                       
###########################################################################################################################
###########Version 0.9.6###################################################################################################
#bug fixes
###########################################################################################################################
#Add Debugging for: []
#No package for dnsmasq and hostapd (Older versions 10.04 and below do not have universe debs active by default, see comments in option 1) []
#No network access after taking PirateBox down (use sudo service network-manager stop and than sudo service network-manager start []
#No access to chat or viewing uploaded folder (Copy from /opt/piratebox/conf/hosts to /etc/hosts) []
#Debug Manual from http://piratebox.aod-rpg.de/dokuwiki/doku.php?id=script-package_for_debian_based_systemes&DokuWiki=93bea71d696f0054de696f11d8acc0e0 []
###########################################################################################################################
#Add ManPages / Manual []
#Quick Manual []
#History of PirateBox []
#Debug Manual from above []
#Help Develope? page []
#Art []
###########################################################################################################################
#GUI []
#Make out of wxPython
#Or Java later on for multiple OS?
###########################################################################################################################
clear
echo -e '\E[0;30m'"\033[1m
__________ __                 __         __________   ____    ____          
\______   \__|____________  _/  |_   ____\______   \ |   _|  |_   | ___  ___
 |     ___/  |\_  __ \__  \ \   __\_/ __ \|    |  _/ |  |      |  | \  \/  /
 |    |   |  | |  | \// __ \_|  |  \  ___/|    |   \ |  |      |  |  >    < 
 |____|   |__| |__|  (____  /|__|   \___  >______  / |  |_    _|  | /__/\_ |
 	 	          \/            \/       \/  |____|  |____|       \/        
\033[0m"                                   
echo ""
PS3='Please enter your choice: '
options=("Quick install for Debian based systems" "Start PirateBox" "Stop PirateBox" "Manage PirateBox Download / Upload Folder" "Configure" "Update" "Quit")

select opt in "${options[@]}"
do
    case $opt in
"Quick install for Debian based systems")
sudo apt-get install perl
sudo apt-get install lighttpd
sudo apt-get install hostapd
sudo apt-get install dnsmasq
sudo wget -P /tmp/ https://github.com/MaStr/PirateBoxScripts_Webserver/raw/master/piratebox-ws_0.2.0.tar.gz
cd /tmp/
sudo cp -i piratebox-ws_0.2.0.tar.gz /opt/piratebox
sudo tar xzvf piratebox-ws_0.2.0.tar.gz
cd /tmp/piratebox
sudo cp -rv piratebox /opt
sudo tar xzvf /opt/piratebox
sudo ln -s /opt/piratebox/init.d/piratebox /etc/init.d/piratebox 
sudo chmod 777 /opt/piratebox/chat/cgi-bin/data.pso
echo "192.168.77.1  piratebox.lan">>/etc/hosts
echo "192.168.77.1  piratebox">>/etc/hosts
wget -P /opt/piratebox/bin https://github.com/terrorbyte/PirateBox-Manager/raw/master/PirateBoxManager.sh
sudo service network-manager stop
sudo killall dhclient
sudo killall dnsmasq
echo "Installed"
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Manage Download / Upload Folder"
echo "5) Configure"
echo "6) Update"
echo "7) Quit"
;;

"Start PirateBox")
sudo /etc/init.d/piratebox start
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Manage Download / Upload Folder"
echo "5) Configure"
echo "6) Update"
echo "7) Quit"
;;

"Stop PirateBox")
sudo /etc/init.d/piratebox stop
sudo service network-manager start
echo ""
echo "1) Quick install for Debian based systems"
echo "2) Start PirateBox"
echo "3) Stop PirateBox"
echo "4) Manage Download / Upload Folder"
echo "5) Configure"
echo "6) Update"
echo "7) Quit"
;;

"Manage PirateBox Download / Upload Folder")
sudo nautilus /opt/piratebox/share
;;

"Quit")
break
;;

"Configure")
echo ""
PS3='Please enter your choice: '
config=("Clear PirateBox Upload Folder" "Change SSID" "Change Channel" "Edit piratebox.conf" "Edit hostapd.conf" "Back" "Quit")
select config in "${config[@]}"
do
    case $config in
"Clear PirateBox Upload Folder")
#read -p "Remove all files AND sub-directories (y/n)"
#[ "$REPLY" == "y" ]
sudo rm -rf /opt/piratebox/share/*
sudo cp -i /opt/piratebox/src/.READ.ME.htm /opt/piratebox/share
sudo cp -i /opt/piratebox/src/.BACK.TO.MENU.htm /opt/piratebox/share
echo "Deleted all files in the directory"
#[ "$REPLY" != "y" ]
#rm /opt/piratebox/share/*
;;
"Change SSID")
echo "Enter new SSID: "
read SSID
sudo sed '3s/.*/ssid='$SSID'/' </opt/piratebox/conf/hostapd.conf> /opt/piratebox/conf/hostapd.conf.new
sudo cp -i /opt/piratebox/conf/hostapd.conf /opt/piratebox/hostapd.conf.bak
sudo cp -i /opt/piratebox/conf/hostapd.conf.new /opt/piratebox/hostapd.conf
;;

"Change Channel")
echo "Enter Channel [1-14]:"
read CHANNEL
#if [ $CHANNEL > 14 ];
#then
#echo "Must be less than 14"
#fi
sudo sed '5s/.*/channel='$CHANNEL'/' </opt/piratebox/conf/hostapd.conf> /opt/piratebox/conf/hostapd.conf.new
sudo cp -i /opt/piratebox/conf/hostapd.conf /opt/piratebox/hostapd.conf.bak
sudo cp -i /opt/piratebox/conf/hostapd.conf.new /opt/piratebox/hostapd.conf
echo "The last revision is backed up in /opt/piratebox/conf/hostapd.conf.bak"
;;

"Edit piratebox.conf")
nano /opt/piratebox/conf/piratebox.conf
;;

"Edit hostapd.conf")
nano /opt/piratebox/conf/hostapd.conf
;;
 
"Back")
sudo bash /opt/piratebox/bin/PirateBoxManager.sh
;;
"Update")
wget -P /tmp/ https://github.com/terrorbyte/PirateBox-Manager/raw/master/PirateBoxManager.sh
wget -P /tmp/ https://github.com/terrorbyte/PirateBox-Manager/raw/master/Update.sh
cd /tmp/
sudo bash Update.sh
;;
"Quit")
break
;;
*) echo invalid option;;
esac
done
break
;;
*) echo invalid option;;

esac
done
