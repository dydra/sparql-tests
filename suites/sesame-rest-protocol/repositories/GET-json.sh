#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories \
 | diff -q - GET-json-response.json > /dev/null

