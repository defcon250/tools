#!/bin/bash

#Uncomment these lines to receive updates info
echo "---"
LOCALVER=1.1
REMOTEVER=$(curl -ks  https://github.com/defcon250/tools/blob/main/ccc.sh | grep -m1 -ioP 'LOCALVER=\w*.?\w*.?\w*.?\w*' | awk -F'=' '{print $2}' | awk -F'<' '{print $1}')
if [[ $LOCALVER != $REMOTEVER ]]; then echo -e "\033[1;31mupdate $REMOTEVER is avaialble for $0\033[m"; fi | grep -iP '[0-9]' || echo ""

