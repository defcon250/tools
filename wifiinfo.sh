#!/bin/bash
LOCALVER=1.0
REMOTEVER=$(curl -ks  https://github.com/defcon250/tools/blob/main/wifiinfo.sh | grep -ioP 'LOCALVER=\w*.?\w*' | awk -F'=' '{print $2}')
if [ $REMOTEVER != 1.0 ]; then echo "update is available"; fi



iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$1" -B1  | grep -i phy | sed 's/#//g') info | grep -i mbps | grep -iv "*" | sort -u | xargs -l
echo ""
VAR_CHANNELS=`iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$1" -B1  | grep -i phy | sed 's/#//g') info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | awk -F ']' '{print $1}' | xargs | tr -s ' ' ','`
echo "$1 Vendor=`udevadm info /sys/class/net/$1 | grep -oiP 'id_oui_from_database=.*' | awk -F'=' '{print $2}'`"
echo "$1 `udevadm info /sys/class/net/$1 | grep -oiP 'driver=\w*' | sort -u`"
echo "Supported Channels=$VAR_CHANNELS"
echo ""

