#! /bin/bash

# test validity constraint

curl -X PUT \
     -w "%{http_code}\n" -f -s \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/undefined_variable_behaviour?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q 400
{"undefined_variable_behaviour":"urn:dydra:error-not"}
EOF

