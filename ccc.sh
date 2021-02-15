#!/bin/bash

#Uncomment these lines to receive updates info
echo "---"
LOCALVER=1.0
REMOTEVER=$(curl -ksq  https://github.com/defcon250/tools/blob/main/ccc.sh 2>/dev/null | grep -m1 -ioP 'LOCALVER=\w*.?\w*.?\w*.?\w*' | awk -F'=' '{print $2}' | awk -F'<' '{print $1}')
sleep 1
if [[ $LOCALVER != $REMOTEVER ]]; then echo -e "\033[1;31mupdate $REMOTEVER is avaialble for $0\033[m"; fi | grep -iP '[0-9]' || echo " "
if [[ $LOCALVER != $REMOTEVER ]]; then wget -q https://github.com/defcon250/tools/blob/main/ccc.sh -O /tmp/ccc.sh.temp ; fi 
WORKINGDIR=pwd
cd /tmp
mv /tmp/ccc.sh.temp $WORKINGDIR
exit

