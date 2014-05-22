#! /bin/bash

# write settings and test the immediate response, test the get response and then delete

curl -f -s -S -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/undefined_variable_behaviour?auth_token=${STORE_TOKEN} <<EOF \
 | json_reformat -m | fgrep -q '"undefined_variable_behaviour":"urn:dydra:error"'
{"undefined_variable_behaviour":"urn:dydra:error"}
EOF


curl -f -s -S -X GET\
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/undefined_variable_behaviour?auth_token=${STORE_TOKEN} \
  | json_reformat -m | fgrep -q '"undefined_variable_behaviour":"urn:dydra:error"'


curl -w "%{http_code}\n" -f -s -S -X DELETE \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/undefined_variable_behaviour?auth_token=${STORE_TOKEN} \
  | fgrep -q 204


curl -X GET \
     -w "%{http_code}\n" -f -s \
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/undefined_variable_behaviour?auth_token=${STORE_TOKEN} \
   | fgrep -q 404
