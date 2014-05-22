#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET \
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN} \
  | json_reformat -m  \
  | fgrep '{"account_name":{"type":"literal","value":"jhacker"}' \
  | fgrep 'read":{"type":"literal","value":true}' \
  | fgrep -q '"write":{"type":"literal","value":false}'