#!/bin/bash

VAR001=$1
VAR002=${2:-443}


cat <<EOF> /tmp/tracert3.temp 
VAR001=\$1
curl -sq  http://ipinfo.io/"\$VAR001" | grep -ivw "readme" | grep -ivw "loc" | grep -iv "timezone" | grep -ivw "postal" | awk -F '{' '{print \$1}' | awk -F '}' '{print \$1}' | xargs 
EOF

echo ""
echo "Network Data"
echo "------------"
#traceroute -T -p "$VAR002" "$VAR001" | tee /tmp/tracert3.out
traceroute -p "$VAR002" "$VAR001" | tee /tmp/tracert3.out
#cat /tmp/tracert3.out
echo ""
echo "GeoIP Data"
echo "----------"
cat /tmp/tracert3.out | egrep -io '[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}' | uniq |  xargs -I {} bash  /tmp/tracert3.temp {};  
echo ""
echo "Host (PTR) Data"
echo "---------------"
cat /tmp/tracert3.out | egrep -io '[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}' | uniq | xargs -I {} host  {} | grep -iv "not found"
rm -f /tmp/tracert3.temp
rm -f /tmp/tracert3.out
