#! /bin/bash

# delete collaboarations 
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -X DELETE \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @DELETE.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN}\&collaborator=jhacker \
  | json_reformat -m | fgrep -v -q '"account_name":"jhacker"'

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN} <<EOF \
 | json_reformat -m | fgrep '"account_name":"jhacker"' | fgrep -q '"write":false'
{"collaborator": "jhacker",
 "read": true,
 "write": false }
EOF
