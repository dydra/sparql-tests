#! /bin/bash

# confirm that invalid arguments cause 400's
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q "400"
{"permissable_ip_addresses":["192.168.1.1", "192..168.1.2"],"privacy_setting": 5}
EOF


curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q "400"
{"permissable_ip_addresses":["192.168.1.1", "192.168.1.2"],"privacy_setting": 7}
EOF