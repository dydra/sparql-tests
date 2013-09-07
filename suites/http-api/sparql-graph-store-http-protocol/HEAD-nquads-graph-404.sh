#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S --head\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN}\&graph=http://dydra.com/graph-name-not \
 | fgrep -q "404"
