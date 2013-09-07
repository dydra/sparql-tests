#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X --head\
     -H "Accept: application/n-quads" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/${DYDRA_REPOSITORY}?auth_token=${STORE_TOKEN}\&graph=http://dydra.com/graph-name \
 | fgrep -q "200 OK"

