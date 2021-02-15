#!/bin/bash

#Uncomment these lines to receive updates info
echo "---"
LOCALVER=1.0
WORKINGDIR=`pwd`
REMOTEVER=$(curl -ksq  https://raw.githubusercontent.com/defcon250/tools/main/ccc.sh 2>/dev/null | grep LOCALVER -m1 |  awk -F'=' '{print $2}')
sleep 1
#if [[ $LOCALVER != $REMOTEVER ]]; then echo -e "\033[1;31mupdate $REMOTEVER is avaialble for $0\033[m"; else echo "This is the latest!"; fi | grep -iP '[0-9]' || echo " "
if [[ $LOCALVER != $REMOTEVER ]]; echo "Update is available!"; then wget -q https://raw.githubusercontent.com/defcon250/tools/main/ccc.sh -O /tmp/ccc.sh.temp 2> /dev/null; cd /tmp; mv /tmp/ccc.sh.temp $WORKINGDIR/ccc.sh; else echo "This is the latest!"; fi 
exit

