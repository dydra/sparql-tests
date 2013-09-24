#! /bin/bash

# verify constraints on about properties
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

# test reserved name
curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} <<EOF \
   | fgrep -q "400"
{
    "name": "sparql"
}
EOF

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

# test invlaid homepage syntax
curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} <<EOF \
   | fgrep -q "400"
{
   "homepage": "//http://example.org/test"
}
EOF

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

# test invalid license
curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} <<EOF \
   | fgrep -q "400"
{
    "license_url": "//http://unlicense.org"
}
EOF

