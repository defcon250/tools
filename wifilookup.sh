#!/bin/bash

VAR001=$1
VAR002=$2
systemctl stop NetworkManager
ifconfig $VAR001 down
iwconfig $VAR001 mode monitor
ifconfig $VAR001 up
tcpdump -i "$VAR001" -s0 -w ./wifi.dump 2> /dev/null &

for i in {1,1}; do iwconfig "$VAR001" channel $i; echo "Waiting in Channel:$i, for $VAR002 seconds. "; sleep "$VAR002" ; done

#for i in {1,2,3,4,5,6,7,8,9,10,11,12,13,36,40,44,48,52,56,60,64,100,104,108,112,116,120,124,128,132,136,140,149,153,157,161,165}; do iwconfig "$VAR001" channel $i; echo "Waiting in Channel:$i, for $VAR002 seconds. "; sleep "$VAR002" ; done

killall tcpdump
tcpdump -tttt -r ./wifi.dump -s0 -e -Avv > ./wifi.out 2> /dev/null
cat ./wifi.out | grep -i beacon > wifi.beacon
cat ./wifi.out | grep -i response > wifi.response
cat ./wifi.beacon | awk -F'BSSID:' '{print $2}' | awk -F'(' '{print $1,$4}' | egrep -iv '^[a-Z0-9]{2}[:][a-Z0-9]{2}[:][a-Z0-9]{2}[:][a-Z0-9]{2}[:][a-Z0-9]{2}[:][a-Z0-9]{2}  )' | awk -F')' '{print $1":"$2}' | awk -F':' '{print $1":"$2":"$3":"$4":"$5":"$6,$8}'| awk -F',' '{print $1,$2}' | sort | uniq -c | sort -rn | tr -s ' ' > ./wifi.ap

echo ""
echo ""
echo "Done.!!"
