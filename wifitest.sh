#!/bin/bash
VAR002=$1
VAR002=$2




#
#FUNCTIONS:-------------------------------------------------------
#


INSTALL() {
which iw 1> /dev/null; if [ "$?" != "0" ]; then echo "iw package is not avialble; thus, installing" ; apt install -y iw ; fi
if [ -f /usr/lib/crda/crda ]; then echo ""; else echo "crda package is not available; thus, installing"; apt install -y crda; fi
clear
echo ""
}

COUNTRYSET() {
mv /usr/lib/crda/regulatory.db /usr/lib/crda/regulatory.db.orig 2> /dev/null
mv /usr/lib/crda/regulatory.bin /usr/lib/crda/regulatory.bin.orig 2> /dev/null
echo "UkdEQgAAABQwMABSQ0EATlVTAEoAAAAAEAALuAAknwAAJbhAAACcQBAADOQAJKbQACW4QAAAnEAQ
EAzkACSm0AAl31AAAJxAEBAI/ABOlTAAUBvQAAE4gBASCPwATpUwAFAb0AABOIAQEAzkAE6VMABQ
G9AAATiAEBQI/ABQG9AAUaJwAAE4gBAUCWAAUBvQAFGicAABOIAQEAzkAFAb0ABRonAAATiAEAQJ
YABTdzAAVXMAAAE4gBAQDOQAU3cwAFdbSAABOIAQBAj8AFN3MABXbtAAAnEAEAQJYABWNlAAV27Q
AAE4gBAQDOQAV1tIAFmlOAABOIAQAAu4AFdu0ABZQ5AAATiAEAAM5ABXglgAWQj4AAE4gBAAD6AD
aWnABDtfwAAg9YADBgEAAAYAEgAeADIAPgBGAwYBAAAKABYAIgAqADYAQgMFAAAADgAaACYALgA6
AAA=" | base64 -d > /usr/lib/crda/regulatory.db
echo "UkdEQgAAABMAAAH0AAAAAwAAAQAAAAAAAAAM5AAAAAAAAAj8AAAAAAAACWAAAAAAAAALuAAAAAAA
AA+gACSm0AAl31AAAJxAAE6VMABQG9AAATiAAFAb0ABRonAAATiAAFN3MABXW0gAATiAAFdbSABZ
pTgAATiAACSm0AAluEAAAJxAAFN3MABVcwAAATiAAFY2UABXbtAAATiAAFeCWABZCPgAATiAACSf
AAAluEAAAJxAAFN3MABXbtAAAnEAAFdu0ABZQ5AAATiAA2lpwAQ7X8AAIPWAAAAAqAAAACwAAAAA
AAAAeAAAABQAAAAAAAAAPAAAABQAAAgAAAAASAAAABwAAAgAAAAASAAAABwAAAgIAAAASAAAABQA
AAgAAAAAVAAAABwAAAgQAAAAVAAAACQAAAgQAAAAVAAAABQAAAgAAAAAhAAAACQAAAAQAAAAYAAA
ABQAAAgAAAAAtAAAABwAAAAQAAAAkAAAACQAAAAQAAAAbAAAABQAAAgAAAAAwAAAACwAAAAAAAAA
nAAAABQAAAAAAAAAzAAAADQAAAAAAAAABgAAANgAAAD8AAABIAAAAVwAAAGAAAABmAAAAAYAAADk
AAABCAAAASwAAAFEAAABaAAAAYwAAAAFAAAA8AAAARQAAAE4AAABUAAAAXQwMAAAAAAB3ENBAAEA
AAHAVVMAAQAAAaRwcj/NIfYuXkX+4ar9AVlSZ20MNMUmn1m/Isl9FdlyPVcncKdQcNd5hVA8JVrs
fGd7uuYxrwnT0B3THZftyCpsuHYQaRN/hl6wsX7isLdjnHBx3ebwpdKcfQUXaijloxy9g+SsO2Kn
jZb86v5c9u5mHrmAI6m31J8YhI4aVpFO9TgfpXwJCgOiCq8QPiOTFILwJvoqFDAEiD/qWAz4Dqc1
EHm2170tHxYuUxy/+xMHy6nYmtZ4ByuV3nWhpaoVaPd53EFi/fJAk49iCjnVGNF7EUVOGBDq6vRv
NADmFD/xqHOQsWjK5Q8k1nkNb6zB15/xu/+GnBiZ1PCttechjhBn" | base64 -d > /usr/lib/crda/regulatory.bin
echo "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FR
OEFNSUlCQ2dLQ0FRRUF1RWZSYkZJei9MZjBWZG91SVdmMQpGRXlkYW5IdkR6Nit3USs3MS9KL28z
dzhEQkYrbGVXR1lZcXgzeSt0bS9ieThCU0UvWlQzZlpnWHRLeFY1a094CnRGZS9pampUdzRMdHk1
MUQvUlA4UG84d1hVRCtzOTNKcVAwTFdsOUlKWklROWl3WmtTN3RSdTlTblVWdVB3elMKa0pwZE9C
bENmdGZUL1N3TGFycUJXdUFER1RTQ2NCbkJsWktRZjNmd3NLTkpreVJYa1ZkbFFlUzZtV1REV0ds
cQpBR1JEN0p4T000cXYzOGQ2QTFqWHFuSU1CdVRzdXI5S09TZ2cxZEJGSUdHaElZNlBSTkI1RzRt
S3Q3TTdRY0JUCnBrSFFsN3JFYk1RVjRrSXY5Y1JyYm9mRGFRZTR1UmUyUC8vRFlnUG1WQmRJQ2t2
eHBxVE14S1ZqWXMvcmRTQ0MKYVFJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==" | base64 -d > /usr/lib/crda/pubkeys/crda.pub.key
iw reg reload 2> /dev/null
iw reg set 00
sleep 1
}

COUNTRYRESET() {
mv /usr/lib/crda/regulatory.db.orig /usr/lib/crda/regulatory.db  2>/dev/null
mv /usr/lib/crda/regulatory.bin.orig /usr/lib/crda/regulatory.bin 2> /dev/null
iw reg set CA
iw reg reload 2> /dev/null
}	



INFO0() {
iw `iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR002" -B1  | grep -i phy -m1 | sed 's/#//g'` info | grep -i mbps | grep -iv "*" | sort -u | xargs -l
echo ""
DEVICE=`iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR002" -B1  | grep -i phy -m1 | sed 's/#//g'` 
VAR_CHANNELS1=`iw $DEVICE info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | wc -l`
VAR_CHANNELS2=`iw $DEVICE info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | awk -F ']' '{print $1}' | xargs | tr -s ' ' ','`

echo "$VAR002 Vendor=`udevadm info /sys/class/net/$VAR002 | grep -oiP 'id_oui_from_database=.*' | awk -F'=' '{print $2}'`"
echo "$VAR002 `udevadm info /sys/class/net/$VAR002 | grep -oiP 'driver=\w*' | sort -u | xargs`"
echo "`iw reg get | grep -i country`" | tr c-c C-C
echo "Supported 5GHz Channels=($VAR_CHANNELS1)=$VAR_CHANNELS2"
echo ""
}




SPEEDTEST() {

cat <<EOF> /tmp/temp.conf
#interface=wlan1
#bridge=br0
driver=nl80211
ssid=test00
hw_mode=a
channel=hello
#macaddr_acl=0
ignore_broadcast_ssid=0
auth_algs=1
#max_num_sta=10
#country_code=CA
#ieee80211d=1
#ieee80211h=1
wpa=2
wpa_key_mgmt=WPA-PSK
wpa_passphrase=abcd12345678
rsn_pairwise=CCMP
#wpa_pairwise=TKIP
ieee80211n=1
require_ht=1
ht_capab=[HT40+][SHORT-GI-20][SHORT-GI-40]
ieee80211ac=1
require_vht=1
vht_oper_chwidth=1
vht_capab=[SHORT-GI-80][HTC-VHT]
vht_oper_centr_freq_seg0_idx=155
#wmm_enabled=1
EOF



rm -f /tmp/001 2> /dev/null
rm -f /tmp/002 2> /dev/null

iw `iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR002" -B1  | grep -i phy -m1 | sed 's/#//g'` info | grep -i mbps | grep -iv "*" | sort -u | xargs -l
echo ""
DEVICE=`iw dev | grep -ioP 'phy#\w*|interface\s\w*'  | grep -i "$VAR002" -B1  | grep -i phy -m1 | sed 's/#//g'` 
VAR_CHANNELS1=`iw $DEVICE info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | wc -l`
VAR_CHANNELS2=`iw $DEVICE info | grep -i Mhz | grep -iv 'radar' | grep -iv disabled | grep -i short  -A 50 | awk -F'[' '{print $2}' | awk -F ']' '{print $1}' | xargs | tr -s ' ' ','`


echo "$VAR002 Vendor=`udevadm info /sys/class/net/$VAR002 | grep -oiP 'id_oui_from_database=.*' | awk -F'=' '{print $2}'`"
echo "$VAR002 `udevadm info /sys/class/net/$VAR002 | grep -oiP 'driver=\w*' | sort -u | xargs`"
echo "`iw reg get | grep -i country`" | tr c-c C-C
echo "Supported 5GHz Channels=($VAR_CHANNELS1)=$VAR_CHANNELS2"
echo ""

echo "for i in {$VAR_CHANNELS2}; do sed -i '/channel/d' /tmp/temp.conf; echo "channel=\$i" >> /tmp/temp.conf; sed -i '/seg0/d' /tmp/temp.conf ; echo "vht_oper_centr_freq_seg0_idx=\`expr \$i + 6\`" >> /tmp/temp.conf ; hostapd -B -i $VAR002 /tmp/temp.conf > /dev/null ; sleep 2; echo "Channel-\$i" >> /tmp/001; iwconfig $VAR002 | grep -i rate | grep -oiP '[0-9]{1,5}\.?[0-9]{1,5}\s\w*..' | grep -i \" \" >> /tmp/002 || echo " " >> /tmp/002; killall hostapd 2> /dev/null ;  sleep 2;  done" > /tmp/000

bash /tmp/000
#paste -d= /tmp/001 /tmp/002 | sort  -t= -k2,2 | tail -n2
paste -d= /tmp/001 /tmp/002 | sort  -t= -k2,2
echo ""
echo ""
}





case $1 in


info)
INSTALL
COUNTRYSET
INFO0
COUNTRYRESET
;;

test)
INSTALL
COUNTRYSET
SPEEDTEST
COUNTRYRESET
;;

update)

echo "---"
WORKINGDIR=`pwd`
FNAME=`echo $0 | awk -F'/' '{print $2}'`
LOCALVER=1.0
REMOTEVER=$(curl -H 'Cache-Control: no-cache' -ksq https://raw.githubusercontent.com/defcon250/tools/main/"$FNAME"?$(date +%s) 2>/dev/null | grep -m1 'LOCALVER' | awk -F'=' '{print $2}')
if [[ $LOCALVER != $REMOTEVER ]]; then echo "Update is available!"; curl -H 'Cache-Control: no-cache' -ksq https://raw.githubusercontent.com/defcon250/tools/main/"$FNAME"?$(date +%s) -o /tmp/"$FNAME".temp 2> /dev/null; cd /tmp; chmod +x /tmp/"$FNAME".temp; mv /tmp/"$FNAME".temp $WORKINGDIR/"$FNAME".sh; else echo "This is the latest!"; fi
echo ""
;;



*)
clear
echo ""
echo "Usage: $0 <options> <interface>"
echo "..."
echo "Options:"
echo ""
echo "	info - shows the information"
echo "	test - tests the wireless interface"
echo "	update - updates the file"
echo ""
;;

esac
LOCALVER=1.1






