#!/usr/bin/env python
import os
import platform
import subprocess
import argparse
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

parser = argparse.ArgumentParser(description="A tool to use your laptops wireless card as a PirateBox. This also stores files for later.")
parser.add_argument("command", metavar="start / stop", help="Start or Stop Piratebox, if you run start and PirateBox is already running it will restart all the everything with the new (or same parameters).\n")
parser.add_argument("-i", "--interface", help="Select an interface, or else defaults to wlan0\n")
parser.add_argument("-c", "--config", help="Specifies a configuration file to use for piratebox, or else it will default to /opt/piratebox/conf/piratebox.conf\n")
parser.add_argument("-s", "--ssid", help="Change your ssid to broadcast.\n")
parser.add_argument("--channel", help="Change channel to broadcast on.\n")
parser.add_argument("-d", "--driver", help="Change your driver for hostapd to use, default is mac80211\n")
parser.add_argument("-g", "--gui", "-m", "--menu", action="store_true", help="Drop into a menu driven system, your settings are not preserved.\n") #g will eventually point to a real gui
 
#TODO
#parser.add_argument("-d", "--dhcp", help="Change dhcp settings, add an example\n")
#parser.add_argument("-n", "--dns", help="Append the specified hosts to redirct (like piratebox.lan\n")
#parser.add_argument("--save", help="Save the settings you specify into a configuration file\n")

args = parser.parse_args()

print(banner)
