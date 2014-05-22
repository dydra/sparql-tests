#! /bin/bash

# write privacy settings and test the immediate response;
# test the get response and then cycle back to the original state
#
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/x-www-form-urlencoded" \
     --data-urlencode @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q "204"
_method=PUT&repository[permissable_ip_addresses]=192.168.1.1,192.168.1.3&repository[privacy_setting]=5
EOF


curl -f -s -S -X GET \
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep '"privacy_setting":5' | fgrep -q '192.168.1.3'


initialize_privacy | fgrep -q "204"


curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep '"privacy_setting":1' | fgrep -q -v '192.168.1.2'
