#! /bin/bash

# write settings and test the immediate response, test the get response and then delete
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -S -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/provenance_repository?auth_token=${STORE_TOKEN}<<EOF \
 | json_reformat -m | fgrep -q '"provenance_repository":"openrdf-sesame/public"'
{"provenance_repository":"openrdf-sesame/public"}
EOF


curl -f -s -S -X GET\
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/provenance_repository?auth_token=${STORE_TOKEN} \
  | json_reformat -m | fgrep -q '"provenance_repository":"openrdf-sesame/public"'

rc=$?


curl -w "%{http_code}\n" -f -s -X DELETE \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/provenance_repository?auth_token=${STORE_TOKEN} \
  | fgrep -q 204
