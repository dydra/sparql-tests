#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+xml" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/namespaces?auth_token=${STORE_TOKEN}\&auth_token=${STORE_TOKEN} \
 | xmllint  --c14n11 - \
 | diff -q - GET-response.mxl > /dev/null

