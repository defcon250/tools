#!/bin/bash

FNAME=`echo $0 | awk -F'/' '{print $2}'`

echo "---"
LOCALVER=1.7
WORKINGDIR=`pwd`
REMOTEVER=$(curl -H 'Cache-Control: no-cache' -ksq https://raw.githubusercontent.com/defcon250/tools/main/"$FNAME"?$(date +%s) 2>/dev/null | grep -m1 'LOCALVER' | awk -F'=' '{print $2}')
sleep 1
if [[ $LOCALVER != $REMOTEVER ]]; then echo "Update is available!"; curl -H 'Cache-Control: no-cache' -ksq https://raw.githubusercontent.com/defcon250/tools/main/"$FNAME"?$(date +%s) -o /tmp/"$FNAME".temp 2> /dev/null; cd /tmp; chmod +x /tmp/ccc.sh.temp; mv /tmp/"$FNAME".temp $WORKINGDIR/"$FNAME".sh; else echo "This is the latest!"; fi 
exit

