#!/bin/bash
VAR001=$1 
VAR002=`echo $VAR001 | tr a-z A-Z`
echo "ibase=16; $VAR002" | bc

