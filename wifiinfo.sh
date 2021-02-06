#!/bin/bash
LOCALVER=1.1
REMOTEVER=$(curl -ks  https://github.com/defcon250/tools/blob/main/wifiinfo.sh | grep -m1 -ioP 'LOCALVER=\w*.?\w*.?\w*.?\w*' | awk -F'=' '{print $2}' | awk -F'<' '{print $1}')



iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$1" -B1  | grep -i phy | sed 's/#//g') info | grep -i mbps | grep -iv "*" | sort -u | xargs -l
echo ""
VAR_CHANNELS=`iw $(iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$1" -B1  | grep -i phy | sed 's/#//g') info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | awk -F ']' '{print $1}' | xargs | tr -s ' ' ','`
echo "$1 Vendor=`udevadm info /sys/class/net/$1 | grep -oiP 'id_oui_from_database=.*' | awk -F'=' '{print $2}'`"
echo "$1 `udevadm info /sys/class/net/$1 | grep -oiP 'driver=\w*' | sort -u`"
echo "Supported Channels=$VAR_CHANNELS"
echo ""





echo "---"
if [[ $REMOTEVER != 1.1 ]]; then echo "update $REMOTEVER is available for $0"; fi
