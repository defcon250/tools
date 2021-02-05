#!/bin/bash
VAR001=$1


DEFAULTIP=`curl -qs http://ipinfo.io | grep -i ip | awk -F '"' '{print $4}'`
INPUT=`echo "$VAR001" | egrep -i '[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}' || host "$VAR001" 2> /dev/null | egrep -i "has address|domain name pointer" -m1 | awk '{print $NF}'` 
IPNUMBER=`echo $INPUT | egrep -i '[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}' || echo $DEFAULTIP`
MOREIPNUMBERS=`echo "$VAR001" | egrep -i '[0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}[.][0-9]{1,3}' || host "$VAR001" 2> /dev/null | egrep -i "has address|domain name pointer" | awk '{print $NF}' | xargs -l`


DEFAULTHOSTNAME=`host $IPNUMBER | egrep -i "has address|domain name pointer" -m1 | awk '{print $NF}'`
MOREHOSTNAMES=`host "$IPNUMBER"| egrep -i "has address|domain name pointer" | awk '{print $NF}' | xargs -l | sed -e 's/.$//'`

EMAILSERVERS=`host "$IPNUMBER" | egrep -i "mail handled by" | awk '{print $NF}' | sed -e 's/.$//'`






#VAR02=${1:-"$DEFAULTIP"}









###### Getting 'whois' information
VAR033=`whois "$IPNUMBER"`

#VAR033=`curl -q -s https://www.whois.com/whois/$IPNUMBER`
#echo "$VAR033"

VAR044=`echo "$VAR033" | egrep -i 'inetnum|route:|netrange|cidr' | awk 'ORS="," {print $1="",$0}' | sort -u | xargs | sed -e 's/,$//'`

###### Geting 'GeoIP' information
#VAR055=`geoiplookup -f /usr/share/GeoIP/GeoIPASNum.dat "$IPNUMBER" | awk -F 'Edition:' '{print $1="",$2}'| sort -u | xargs`
VAR055=`curl -sq http://ipinfo.io/8.8.8.8 | grep -i org | egrep -io 'AS[0-9]{1,10}'`
#VAR066=`geoiplookup -f /usr/share/GeoIP/GeoIPCity.dat "$IPNUMBER" | awk -F':' '{print $1="",$0}'  | xargs`
VAR066=`curl -sq  http://ipinfo.io/"$IPNUMBER" | grep -ivw "hostname" | grep -ivw "readme" | grep -ivw "loc" | grep -iv "timezone" | grep -ivw "postal" | awk -F '{' '{print $1}' | awk -F '}' '{print $1}' | xargs`
VAR0555=`echo "$VAR033" | egrep -i '^address|^city|^country' | awk 'ORS="," {print $1="",$0}' | sort -u | xargs | sed -e 's/,$//'`
#VAR0666=`echo "$VAR033" | egrep -i '^orgnocemail|^orgabuseemail|^orgtechemail|abuseemail' | sort -u | awk 'ORS="," {print $1="",$0}' | xargs | sed -e 's/,$//'`
VAR0666=`echo "$VAR033" | egrep -i '*.*@.*' | awk '{print $NF}' | sort -u | awk 'ORS="; " {print $0}' | xargs | sed -e 's/,$//'`

echo ""
echo -e "\033[1;31mIP-Number:\033[m"
echo "$IPNUMBER"
echo ""
echo -e "\033[1;31mReverse-HostLookup:\033[m"
echo "$DEFAULTHOSTNAME"
echo ""
echo -e "\033[1;31mAssociated-IP-Numbers:\033[m"
echo "$MOREIPNUMBERS"
echo ""
echo -e "\033[1;31mAssociated-Domain-Names:\033[m"
echo "$MOREHOSTNAMES"
echo ""
echo -e "\033[1;31mNetwork Subnet Info:\033[m"
echo "$VAR044"
echo ""
#echo -e "\033[1;31mGeoIP-ASN-Number:\033[m"
#echo "$VAR055"
#echo ""
echo -e "\033[1;31mGeoIP Location:\033[m"
echo "$VAR066"
echo ""
echo -e "\033[1;31mAssociated Address (WhoIS):\033[m"
echo "$VAR0555"
echo ""
echo -e "\033[1;31mAssociated Emails (WhoIS):\033[m"
echo "$VAR0666"
echo ""
echo 
