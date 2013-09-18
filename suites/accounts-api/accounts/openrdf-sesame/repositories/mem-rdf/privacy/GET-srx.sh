#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+xml" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
  | xmllint --c14n11 - \
  | diff -q - GET-response.srx > /dev/null

