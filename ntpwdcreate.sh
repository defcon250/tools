#!/bin/bash
VAR001=$1
echo -n "$VAR001" | iconv -t utf16le | openssl md4 | awk -F'=' '{print $2}'| xargs 
