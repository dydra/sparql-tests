#! /bin/bash

# test validity constraint
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -X PUT \
     -w "%{http_code}\n" -f -s \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/provenance_repository?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q 400
{"provenance_repository":"urn:dydra:error-not"}
EOF

