#!/bin/bash

#Uncomment these lines to receive updates info
echo "---"
LOCALVER=1.0
WORKINGDIR=`pwd`
REMOTEVER=$(curl -H 'Cache-Control: no-cache' -ksq https://raw.githubusercontent.com/defcon250/tools/main/ccc.sh?$(date +%s) 2>/dev/null | grep -m1 -ioP 'LOCALVER=\w*.?\w*.?\w*.?\w*' | awk -F'=' '{print $2}' | awk -F'<' '{print $1}')
sleep 1
#if [[ $LOCALVER != $REMOTEVER ]]; then echo -e "\033[1;31mupdate $REMOTEVER is avaialble for $0\033[m"; else echo "This is the latest!"; fi | grep -iP '[0-9]' || echo " "
if [[ $LOCALVER != $REMOTEVER ]]; then echo "Update is available!"; curl -H 'Cache-Control: no-cache' -ksq https://raw.githubusercontent.com/defcon250/tools/main/ccc.sh?$(date +%s) --output /tmp/ccc.sh.temp 2> /dev/null; cd /tmp; chmod +x /tmp/ccc.sh.temp; mv /tmp/ccc.sh.temp $WORKINGDIR/ccc.sh; else echo "This is the latest!"; fi 
exit

