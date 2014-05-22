#! /bin/bash

# write settings and test the immediate response, test the get response and then delete
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -X PUT \
     -w "%{http_code}\n" -f -s \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q 400
{"default_context_term":"urn:dydra:not", "named_contexts_term":"urn:dydra:named"}
EOF
