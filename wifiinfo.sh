#!/bin/bash

VAR001=${1:-null} 


iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR001" -B1  | grep -i phy | sed 's/#//g') info 2>/dev/null | egrep -i 'data rate|highest supported' | grep -iv "*" | sort -u | xargs -l
echo "" 
VAR_CHANNELS=`iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR001" -B1  | grep -i phy | sed 's/#//g') info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | awk -F ']' '{print $1}' | xargs | tr -s ' ' ','` 
echo "Vendor=`udevadm info /sys/class/net/$VAR001 2>/dev/null | grep -oiP 'id_oui_from_database=.*' | awk -F'=' '{print $2}'`" 
echo "`udevadm info /sys/class/net/$VAR001 2>/dev/null | grep -oiP 'driver=\w*' | sort -u`" 
echo "Supported Channels=$VAR_CHANNELS" 
echo ""



