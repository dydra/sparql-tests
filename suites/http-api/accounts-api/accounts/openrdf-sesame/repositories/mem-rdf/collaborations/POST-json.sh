#! /bin/bash

# cycle the privacy setting to test success
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN} <<EOF \
 | json_reformat -m | fgrep '"account_name":"jhacker"' | fgrep -q '"write":true'
{"collaborator": "jhacker",
 "read": false,
 "write": true }
EOF


initialize_collaboration | fgrep -q 204
