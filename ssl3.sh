#!/bin/sh
VAR001=$1
VAR002=$2
VAR003=$3
VAR004=$4

#openssl ocsp -issuer /etc/letsencrypt/archive/ssl.botgoog.com/chain1.pem  -cert /etc/letsencrypt/archive/ssl.botgoog.com/cert1.pem  -text -url http://ocsp.int-x1.letsencrypt.org/
#openssl ocsp -issuer /etc/letsencrypt/archive/ssl.botgoog.com/chain1.pem  -cert /etc/letsencrypt/archive/ssl.botgoog.com/cert1.pem  -text -url http://ocsp.int-x1.letsencrypt.org/ -header host=ocsp.int-x1.letsencrypt.org
#openssl x509 -inform PEM -subject_hash_old -in smartssl.pem
#openssl x509 -noout -fingerprint -sha1 -inform pem -in smartssl.pem



TYPE=$(file -b "$VAR002" | egrep -io 'pem certificate$|certificate request$|rsa private key$|ascii text$|data$' | tr '[:upper:]' '[:lower:]')

#echo "$TYPE"

case $1 in

read)
if [ "$TYPE" = "pem certificate" ]
	#then openssl x509 -in $VAR002 -text -noout 
	then openssl crl2pkcs7 -nocrl -certfile $VAR002 | openssl pkcs7 -print_certs -text -noout
elif [ "$TYPE" = "data" ]
#	then openssl x509 -in $VAR002 -inform der -noout -text || openssl pkcs12 -info -in $VAR002
	then openssl x509 -in $VAR002 -inform der -noout -text
#	then openssl pkcs12 -info -in $VAR002 
elif [ "$TYPE" = "certificate request" ]
	then openssl req -text -noout -verify -in $VAR002
elif [ "$TYPE" = "rsa private key" ]
	then openssl rsa -in $VAR002 -check
elif [ "$TYPE" = "ascii text" ]
	then openssl rsa -in $VAR002 -check
fi

;;


modulus)

if [ "$TYPE" = "pem certificate" ]
	then openssl x509 -noout -modulus -in "$VAR002" | openssl md5 | awk -F'=' '{print $2}'| xargs 
	openssl x509 -noout -fingerprint -sha1 -inform pem -in "$VAR002"
elif [ "$TYPE" = "data" ] 
	then openssl pkcs12 -in $VAR002 -nokeys -out /tmp/temp00.cert && openssl pkcs12 -in $VAR002 -nocerts -out /tmp/temp11.key -nodes && cat /tmp/temp00.cert | grep 'BEGIN CERTIFICATE' -A50 > /tmp/temp11.cert && openssl rsa -noout -modulus -in /tmp/temp11.key | openssl md5 | awk -F'=' '{print $2}'| xargs && openssl x509 -noout -modulus -in /tmp/temp11.cert | openssl md5 | awk -F'=' '{print $2}'| xargs && rm -rf /tmp/temp00.* /tmp/temp11.* 	
elif [ "$TYPE" = "certificate request" ]
	then openssl req -noout -modulus -in "$VAR002" | openssl md5 |awk -F'=' '{print $2}'| xargs
elif [ "$TYPE" = "rsa private key" ]
	then openssl rsa -noout -modulus -in "$VAR002" | openssl md5 | awk -F'=' '{print $2}'| xargs
elif [ "$TYPE" = "ascii text" ]
	then openssl rsa -noout -modulus -in "$VAR002" | openssl md5 | awk -F'=' '{print $2}'| xargs
fi

;;

exportpfx)

if [ "$TYPE" = "data" ]
	then openssl pkcs12 -in $VAR002 -nokeys -out /tmp/temp00.cert && openssl pkcs12 -in $VAR002 -nocerts -out abcd.key -nodes && cat /tmp/temp00.cert | grep 'BEGIN CERTIFICATE' -A50 > ./abcd.cert && rm -f /tmp/temp00.cert
	
fi
;;

createpfx)

#if [ "$TYPE" = "pem certificate" ]
#if [ "$TYPE" = "data" ]
	openssl pkcs12 -export -out abcd.pfx -inkey $VAR002 -in $VAR003
#	openssl pkcs12 -export -out abcd.pfx -inkey $VAR002 -in $VAR003 -certfile $VAR004
#elif [ "$TYPE" = "certificate request" ]
#elif [ "$TYPE" = "rsa private key" ]
#elif [ "$TYPE" = "ascii text" ]
#fi
;;

checkca)
#openssl verify -verbose -CAfile RootCert.pem Intermediate.pem
openssl verify -verbose -CAfile "$VAR002"  "$VAR003"
;;

der2pem)
openssl x509 -inform der -in "$VAR002" -out "$VAR002".pem
;;

pem2der)
openssl x509 -outform der -in "$VAR002" -out "$VAR002".der
;;

sha1hash)
openssl x509 -noout -fingerprint -sha1 -inform pem -in "$VAR002"
;;

subhash)
openssl x509 -inform PEM -subject_hash_old -in "$VAR002"
;;

pubkey)
openssl x509 -in "$VAR002"  -pubkey -noout
;;


pvk2pem)
openssl rsa -inform pvk -in "$VAR002" -outform pem -out "$VAR002".pem
;;


certpinf)
true | openssl x509 -in "$VAR002" -pubkey -noout 2> /dev/null | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
;;


certpind)
true | openssl s_client -connect "$VAR002":443 2> /dev/null | openssl x509 -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
;;

checkkey)
echo 'Pair is Matching' | openssl rsautl -encrypt -pubin -oaep -inkey "$VAR002" > message.bin && openssl rsautl -decrypt -in message.bin -inkey "$VAR003"  -oaep
;;

adbcert)
VARHASH=`openssl x509 -inform PEM -subject_hash_old -in "$VAR002" | head -1`
cat "$VAR002" > "$VARHASH".0
openssl x509 -in "$VAR002" -text -noout | awk 'NF' >> "$VARHASH".0
openssl x509 -noout -fingerprint -sha1 -inform pem -in "$VAR002" >> "$VARHASH".0
;;

*) 
echo "Usage : $0 read fileName <such as pfx cert crt pem key csr>  => installes the required dependencies"
echo "Usage : $0 modulus fileName <such as pfx cert crt pem key csr>  => installes the required dependencies"
echo "Usage : $0 exportpfx fileName  => exports PFX to abcd.cert and abcd.key"
echo "Usage : $0 createpfx keyFile certFile => create a abcd.pfx"
echo "Usage : $0 checkca <CA-file> <Cert-file> check the CA cert matching"
echo "Usage : $0 pvk2pem <Cert-file> > converts pvk to pem"
echo "Usage : $0 der2pem <Cert-file> > converts der to pem"
echo "Usage : $0 pem2der <Cert-file> => converts pem to der"
echo "Usage : $0 subhash <Cert-file> => prints subject hash"
echo "Usage : $0 sha1hash <Cert-file> => prints sha1hash of the certificate"
echo "Usage : $0 pubkey <Cert-file> => exports public key of the certificate"
echo "Usage : $0 certpinf <Cert-file> => exports sha256 certpin of certificate"
echo "Usage : $0 certpind <domain> => exports sha256 certpin of domain"
echo "Usage : $0 checkkey <public key> <private key> => checks public and private key match"
echo "Usage : $0 adbcert <Cert-file> => creates android certificate"

exit
;;

esac

