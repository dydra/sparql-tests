#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
  | json_reformat -m | diff -q - GET-response.json > /dev/null

