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
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} <<EOF \
 | json_reformat -m | fgrep '"default_context_term":"urn:dydra:all"' | fgrep -q '"named_contexts_term":"urn:dydra:named"'
{"default_context_term":"urn:dydra:all", "named_contexts_term":"urn:dydra:named"}
EOF


curl -f -s -S -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} <<EOF \
 | json_reformat -m | fgrep '"default_context_term":"urn:dydra:default"' | fgrep -q '"named_contexts_term":"urn:dydra:named"'
{"default_context_term":"urn:dydra:default", "named_contexts_term":"urn:dydra:named"}
EOF


curl -f -s -S -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} <<EOF \
 | json_reformat -m | fgrep '"default_context_term":"urn:dydra:named"' | fgrep -q '"named_contexts_term":"urn:dydra:named"'
{"default_context_term":"urn:dydra:named", "named_contexts_term":"urn:dydra:named"}
EOF


curl -f -s -S -X GET\
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
  | json_reformat -m | fgrep '"default_context_term":"urn:dydra:named"' | fgrep -q '"named_contexts_term":"urn:dydra:named"'


curl -w "%{http_code}\n" -f -s -X DELETE \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
  | fgrep -q 204


curl -X GET \
     -w "%{http_code}\n" -f -s \
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
   | fgrep -q "404"
