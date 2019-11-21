#!/bin/bash
DOMAINS="domain1,domain2"
IFS=', ' read -r -a array <<< "$DOMAINS"
DNS_STR=""
for(( i=0; i<${#array[@]}; i++)) do
if [ $i -eq 0 ] ; then
DNS_STR="DNS:${array[i]}"
else
DNS_STR="${DNS_STR},DNS:${array[i]}"
fi
done;
openssl genrsa 4096 > account.key
openssl genrsa 4096 > domain.key
openssl req -new -sha256 -key domain.key -subj "/" -reqexts SAN -config <(cat /etc/pki/tls/openssl.cnf <(printf "[SAN]\nsubjectAltName=${DNS_STR}")) > domain.csr