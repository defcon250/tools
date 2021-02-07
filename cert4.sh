#!/bin/bash
VAR001=$1
#VAR002={1:-tls1_2}


echo $VAR001 >> /tmp/cert.host
timeout 2s openssl s_client -connect $VAR001:443 2>/dev/null | grep -i "begin certificate" -A 100 | tac | grep -i "end certificate" -A 100 | tac > /tmp/cert.temp 
#openssl x509 -in /tmp/cert.temp -text -noout 2>/dev/null
openssl x509 -in /tmp/cert.temp -text -noout 2>/dev/null | grep -i subject | grep -ioP 'CN.*' | grep -i " " >> /tmp/cert.name || echo NotAvailable >> /tmp/cert.name
#openssl x509 -in /tmp/cert.temp -pubkey -noout 2> /dev/null | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64 >> /tmp/cert.pub
openssl x509 -in /tmp/cert.temp -pubkey -noout 2> /dev/null | md5sum | awk  '{print $1}' >> /tmp/cert.md5


