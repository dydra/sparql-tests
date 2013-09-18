#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: text/plain" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size?auth_token=${STORE_TOKEN}\&context=http://dydra.com/graph-name \
 | diff -q - GET-response-context.txt > /dev/null

