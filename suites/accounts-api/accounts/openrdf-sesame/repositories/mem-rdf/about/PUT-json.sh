#! /bin/bash

# cycle various about setting and test success
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} <<EOF \
  | fgrep -q "204"
{
    "name": "mem-rdf",
    "homepage": "http://example.org/test",
    "summary": "a summary",
    "description": "a description",
    "license_url": null
}
EOF

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} <<EOF \
  | fgrep -q "204"
{
    "name": "mem-rdf",
    "summary": "a summary",
    "description": "a description",
    "license_url": null
}
EOF

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} <<EOF \
  | fgrep -q "204"
{
    "name": "mem-rdf",
    "description": "a description",
    "license_url": "http://unlicense.org"
}
EOF

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep -q '{"about":5}'
rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @PUT-1.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} \
 | fgrep -q "204"

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep -q '{"privacy":1}'
