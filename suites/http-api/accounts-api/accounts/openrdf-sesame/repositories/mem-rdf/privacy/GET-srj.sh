#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
  | json_reformat -m \
  | fgrep '{"privacy_setting":{"type":"literal","value":1}' \
  | fgrep -q '"permissable_ip_addresses":{"type":"literal","value":"192.168.1.1"}'

