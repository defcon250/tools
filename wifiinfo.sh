#!/bin/bash

VAR001=${1:-null} 


iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR001" -B1  | grep -i phy | sed 's/#//g') info 2>/dev/null | egrep -i 'data rate|highest supported' | grep -iv "*" | sort -u | xargs -l
echo "" 
VAR_CHANNELS=`iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR001" -B1  | grep -i phy | sed 's/#//g') info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | awk -F ']' '{print $1}' | xargs | tr -s ' ' ','` 
echo "Vendor=`udevadm info /sys/class/net/$VAR001 2>/dev/null | grep -oiP 'id_oui_from_database=.*' | awk -F'=' '{print $2}'`" 
echo "`udevadm info /sys/class/net/$VAR001 2>/dev/null | grep -oiP 'driver=\w*' | sort -u`" 
echo "Supported Channels=$VAR_CHANNELS" 
echo ""





echo "---"
LOCALVER=1.1
REMOTEVER=$(curl -ks  https://github.com/defcon250/tools/blob/main/wifiinfo.sh | grep -m1 -ioP 'LOCALVER=\w*.?\w*.?\w*.?\w*' | awk -F'=' '{print $2}' | awk -F'<' '{print $1}')
if [[ $LOCALVER != $REMOTEVER ]]; then echo -e "\033[1;31mupdate $REMOTEVER is avaialble for $0\033[m"; fi | grep -iP '[0-9]' || echo ""

