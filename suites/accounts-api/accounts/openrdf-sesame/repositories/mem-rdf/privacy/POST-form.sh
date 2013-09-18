#! /bin/bash

# cycle the privacy setting to test success
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/x-www-form-urlencoded" \
     --data-binary @PUT-5.www \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
 | fgrep -q "204"

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep -q '{"privacy":5}'
rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @PUT-1.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
 | fgrep -q "204"

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep -q '{"privacy":1}'
