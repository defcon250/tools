#!/bin/bash
VAR001=$1
echo "header = Accept-Language: en-us,en;q=0.5" > ~/.wgetrc
echo "header = Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" >> ~/.wgetrc
echo "header = Connection: keep-alive" >> ~/.wgetrc
echo "user_agent = Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:40.0) Gecko/20100101 Firefox/50.0" >> ~/.wgetrc
echo "referer = /" >> ~/.wgetrc
echo "robots = off" >> ~/.wgetrc



wget --no-check-certificate --limit-rate 100K -mkEpnp "$VAR001"

