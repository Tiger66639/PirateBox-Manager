#!/usr/bin/env python
import os
import platform
import subprocess

###Pre-recs###
#dnsmasq
#hostapd
#lighttpd

if os.getuid() != 0:
	print("\033[31m[*] You must be root. Use su or sudo python piratebox.py.\033[0m")
	exit()


