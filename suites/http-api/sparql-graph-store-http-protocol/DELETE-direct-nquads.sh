#! /bin/bash

# test that delete leaves an empty repository

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S -X DELETE\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} \
 | fgrep -q "200 OK"

if [[ "0" == "$rc" ]]
then
  curl -w "%{http_code}\n" -f -s -S -X GET\
       -H "Accept: application/n-quads" \
       $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} \
   | fgrep -q "404"
  rc=$?
fi

exit  $rc 
