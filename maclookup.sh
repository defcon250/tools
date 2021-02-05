#!/bin/sh
VAR001=$1
#VAR005=${5:-default} 

VAR001=$1
VAR002=`echo $1 | awk -F':|-' '{print $1$2$3}'`
grep -i -m1 $VAR002 /opt/oui.txt |  xargs | awk '{print $1=$2=$3="",$0}' | xargs
#grep -i -m1 $VAR002 /var/lib/ieee-data/oui.txt |  xargs | awk '{print $1=$2="",$0}' | xargs


case $1 in

update)
wget http://standards-oui.ieee.org/oui/oui.txt -O /opt/oui.txt
;;


2)
;;


3)
;;


4)
;;


*) 
#echo "Usage : $0 11:22:33:44:55:66"
#echo "Usage : $0 update => updates the OUI database"
#exit
;;

esac
