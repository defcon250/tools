#!/bin/bash

echo "---"
LOCALVER=1.5
WORKINGDIR=`pwd`
REMOTEVER=$(curl -H 'Cache-Control: no-cache' -ksq https://raw.githubusercontent.com/defcon250/tools/main/ccc.sh?$(date +%s) 2>/dev/null | grep -m1 'LOCALVER' | awk -F'=' '{print $2}')
sleep 1
if [[ $LOCALVER != $REMOTEVER ]]; then echo "Update is available!"; curl -H 'Cache-Control: no-cache' -ksq https://raw.githubusercontent.com/defcon250/tools/main/ccc.sh?$(date +%s) --output /tmp/ccc.sh.temp 2> /dev/null; cd /tmp; chmod +x /tmp/ccc.sh.temp; mv /tmp/ccc.sh.temp $WORKINGDIR/ccc.sh; else echo "This is the latest!"; fi 
exit

