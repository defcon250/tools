#!/bin/bash

VAR001=${1:-null} 




iw `iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR001" -B1  | grep -i phy -m1 | sed 's/#//g'` info | grep -i mbps | grep -iv "*" | sort -u | xargs -l
echo ""
DEVICE=`iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR001" -B1  | grep -i phy -m1 | sed 's/#//g'` 
VAR_CHANNELS1=`iw $DEVICE info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | wc -l`
VAR_CHANNELS2=`iw $DEVICE info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | awk -F ']' '{print $1}' | xargs | tr -s ' ' ','`

echo "$VAR001 Vendor=`udevadm info /sys/class/net/$VAR001 | grep -oiP 'id_oui_from_database=.*' | awk -F'=' '{print $2}'`"
echo "$VAR001 `udevadm info /sys/class/net/$VAR001 | grep -oiP 'driver=\w*' | sort -u | xargs`"
echo "`iw reg get | grep -i country`" 
echo "Supported 5GHz Channels=($VAR_CHANNELS1)=$VAR_CHANNELS2"
echo ""
