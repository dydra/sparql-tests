#! /bin/bash

# write settings and test the immediate response, test the get response and then delete
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -X PUT \
     -w "%{http_code}\n" -f -s 
     -H "Content-Type: application/json" \
     --data-binary @PUT-400.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
 | fgrep -q 400
