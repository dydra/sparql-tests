#! /bin/bash

# delete collaboarations 
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -X DELETE \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN}\&collaborator=jhacker <<EOF \
  | json_reformat -m  | fgrep -v -q '"account_name":"jhacker"'
{"collaborator": "jhacker" }
EOF


initialize_collaboration | fgrep -q 204
