#!/bin/bash
VAR001=${1:-security}
VAR002=${2:-`date +"%Y-%m-%d" -d yesterday`}
VAR003=${3:-00:00:00}
VAR004=${4:-`date +"%Y-%m-%d"`}
VAR005=${5:-00:00:00}
echo "Usage: ./loglookup.sh logfile FROM-date FROM-time TO-date TO-time"
echo "Example: ./loglookup.sh $VAR001 $VAR002 $VAR003 $VAR004 $VAR005"
echo""


VARSTART=`date -d "$VAR002"T"$VAR003" +%s | xargs -I{} date -u -d @{} "+%Y-%m-%dT%T"`
#VARSTOP=`date -d "$VAR004"T"$VAR005" +%s | xargs -I{} date -u -d @{} "+%Y-%m-%dT%T"`
VARSTOP=`date +"%Y-%m-%dT%T"`


echo "$VARSTART"
echo "$VARSTOP"

#wevtutil qe "$VAR001" /q:"*[System[TimeCreated[@SystemTime>='"$VARSTART"' and @SystemTime<='"$VARSTOP"']]] and *[System[(EventID=1100)]]"  /f:text
wevtutil.exe qe "$VAR001" /q:"*[System[TimeCreated[@SystemTime>='"$VARSTART"' and @SystemTime<='"$VARSTOP"']]]" /f:text > /tmp/$(hostname -s)-$VAR001.000


cat /tmp/$(hostname -s)-$VAR001.000 | egrep -i "date: " | awk '{print $2}' | awk -F'-' '{print $1$2$3}' | awk -F[./:] '{print $1$2$3}' | grep -i '^[0-9]' > /tmp/$(hostname -s)-$VAR001.001
cat /tmp/$(hostname -s)-$VAR001.000 | egrep -i "event id: " | awk '{print $3}' > /tmp/$(hostname -s)-$VAR001.002
cat /tmp/$(hostname -s)-$VAR001.000 | grep -i "description: " -A1 | grep -iv "description: " | grep -iv '^--' > /tmp/$(hostname -s)-$VAR001.003
echo ""
echo "Done.!; Refer /tmp/$(hostname -s)-$VAR001.XXX files" 

