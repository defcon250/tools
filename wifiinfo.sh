#!/bin/bash
LOCALVER=1.0



iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$1" -B1  | grep -i phy | sed 's/#//g') info | grep -i mbps | grep -iv "*" | sort -u | xargs -l
echo ""
VAR_CHANNELS=`iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$1" -B1  | grep -i phy | sed 's/#//g') info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | awk -F ']' '{print $1}' | xargs | tr -s ' ' ','`
echo "$1 Vendor=`udevadm info /sys/class/net/$1 | grep -oiP 'id_oui_from_database=.*' | awk -F'=' '{print $2}'`"
echo "$1 `udevadm info /sys/class/net/$1 | grep -oiP 'driver=\w*' | sort -u`"
echo "Supported Channels=$VAR_CHANNELS"
echo ""





echo "---"
REMOTEVER=$(curl -ks  https://github.com/defcon250/tools/blob/main/wifiinfo.sh | grep -m1 -ioP 'LOCALVER=\w*.?\w*.?\w*.?\w*' | awk -F'=' '{print $2}' | awk -F'<' '{print $1}')
if [[ $LOCALVER != $REMOTEVER ]]; then echo -e "\033[1;31mupdate $REMOTEVER is avaialble for $0\033[m"; fi | grep -iP '[0-9]' || echo ""

