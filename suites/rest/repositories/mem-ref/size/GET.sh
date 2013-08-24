#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: text/plain" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/size \
 | diff -q - GET-plain.json > /dev/null

