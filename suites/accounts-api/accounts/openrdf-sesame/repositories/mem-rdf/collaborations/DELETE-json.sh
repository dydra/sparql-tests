#! /bin/bash

# cycle the privacy setting to test success
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -X DELETE \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @DELETE.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN}\&collaborator=jhacker \
  | json_reformat -m | diff -q - DELETE-response.json > /dev/null

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @POST-read.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN} \
 | json_reformat -m | diff -q - POST-read-response.json > /dev/null

