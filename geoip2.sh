#!/bin/bash
VAR001=$1
curl -sq  http://ipinfo.io/"$VAR001" | grep -ivw "readme" | grep -ivw "loc" | grep -iv "timezone" | grep -ivw "postal" | awk -F '{' '{print $1}' | awk -F '}' '{print $1}' | xargs 
