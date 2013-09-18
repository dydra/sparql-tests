#! /bin/bash

# write settings and test the immediate response, test the get response and then delete
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -S -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @PUT-all-named.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
 | json_reformat -m | diff -q - PUT-all-named.json > /dev/null

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @PUT-default-named.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
 | json_reformat -m | diff -q - PUT-default-named.json > /dev/null

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @PUT-named-named.json \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
 | json_reformat -m | diff -q - PUT-named-named.json > /dev/null

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
  | json_reformat -m | diff -q - PUT-named-named.json > /dev/null

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -w "%{http_code}\n" -f -s -X DELETE \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/context_terms?auth_token=${STORE_TOKEN} \
  | fgrep -q 204
