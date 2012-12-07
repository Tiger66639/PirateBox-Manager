#!/usr/bin/env python
import os
import shutil
import platform
import subprocess
import argparse
import configparser
###Pre-recs###
#dnsmasq
#hostapd
#lighttpd

if os.getuid() != 0:
	print("\033[31m[*] You must be root. Use su or sudo python piratebox.py.\033[0m")
	exit()

banner = """
\033[1m
__________ __                 __         __________   ____    ____          
\______   \__|____________  _/  |_   ____\______   \ |   _|  |_   | ___  ___
 |     ___/  |\_  __ \__  \ \   __\_/ __ \|    |  _/ |  |      |  | \  \/  /
 |    |   |  | |  | \// __ \_|  |  \  ___/|    |   \ |  |      |  |  >    < 
 |____|   |__| |__|  (____  /|__|   \___  >______  / |  |_    _|  | /__/\_ |
                          \/            \/       \/  |____|  |____|       \/        
\033[0m
"""
#Command Line Arguments
parser = argparse.ArgumentParser(description="A tool to use your laptops wireless card as a PirateBox. This also stores files for later.")
parser.add_argument("command", metavar="start / stop", help="Start or Stop Piratebox, if you run start and PirateBox is already running it will restart all the everything with the new (or same parameters).\n")
parser.add_argument("-i", "--interface", help="Select an interface, or else defaults to wlan0\n")
parser.add_argument("-c", "--config", help="Specifies a configuration file to use for piratebox, or else it will default to /opt/piratebox/conf/piratebox.conf\n")
parser.add_argument("-s", "--ssid", help="Change your ssid to broadcast.\n")
parser.add_argument("--channel", help="Change channel to broadcast on.\n")
parser.add_argument("-d", "--driver", help="Change your driver for hostapd to use, default is mac80211\n")
parser.add_argument("-l", "--lighttpd", help="Specify a lighttpd config file")
parser.add_argument("-n", "--dnsmasq", help="Specify a dnsmasq config file")
parser.add_argument("-a", "--hostapd", help="Specify a hostapd config file")
parser.add_argument("-g", "--gui", "-m", "--menu", action="store_true", help="Drop into a menu driven system, your settings are not preserved.\n") #g will eventually point to a real gui
 
#TODO
#parser.add_argument("-d", "--dhcp", help="Change dhcp settings, add an example\n")
#parser.add_argument("-n", "--dns", help="Append the specified hosts to redirct (like piratebox.lan\n")
#parser.add_argument("--save", help="Save the settings you specify into a configuration file\n")

args = parser.parse_args()

#Main function
#Print Banner
def main():
	print(banner)
	if args.command.lower() == "start":
		start()
	elif args.command.lower() == "stop":
		stop()
	#else may not be necessary due to arg parser catching it.
	#else:
		#print("Incorrect input: you must use start or stop") 
#Declarations
#lighttpd_conf = "/opt/piratebox/conf/piratebox_lighttpd.conf"
#hostapd_conf = "/opt/piratebox/conf/piratebox_hostapd.conf"
#dnsmasq_conf = "/opt/piratebox/conf/dnsmasq.conf"
lighttpd_conf = "/opt/piratebox/conf/piratebox_lighttpd.conf"
hostapd_conf = "/opt/piratebox/conf/piratebox_hostapd.conf"
dnsmasq_conf = "/opt/piratebox/conf/dnsmasq.conf"

def default_config():
	interface = "wlan0" #TODO change to config parser
	driver = "nl80211"
	ssid = "PirateBox: Share Freely"
	hw_mode = "g" #TODO g+n?
	channel = "8"
	auth_algs = "1" 

def custom_config():
	#TODO Parse the specified config
	print("custom_config") #place holder TODO delete
	#interface = #config parser
	#driver = #config parser
	#ssid
	#hw_mode
	#channel
	#auth_algs	

#Gui def
def gui():
	#print("Requires root")
	subprocess.call("sudo bin/bash /opt/piratebox/PirateBoxMenu.sh", shell = True)
	exit()

#Config Parser
#First check if the user wants to read a different config
if args.config:
        custom_config()
else:
	default_config()

#Parse Command line args (These overwrite config file)
#First check for gui so you don't waste resources
if args.gui:
	gui()

if args.interface:
	interface = args.interface

if args.ssid:
	ssid = args.ssid

if args.channel:
	channel = args.channel

if args.driver:
	driver = args.driver

#TODO Rename lighttpd_conf to something not confusable with args.lighttpd-conf, for all of the below
if args.lighttpd:
	lighttpd_conf = args.lighttpd

if args.dnsmasq:
	dnsmasq_conf = args.dnsmasq

if args.hostapd:
	hostapd_conf = args.dnsmasq

#Start function
def start():
	#Start Lighttpd
	subprocess.call("lighttpd -f %s" % lighttpd_conf, shell=True)
	#Start Dnsmasq
	#subprocess.call(shell = True, "dnsmasq"
	#Start Hostapd
#Stop function
def stop():
	print("Stop")

#Call main
main()
