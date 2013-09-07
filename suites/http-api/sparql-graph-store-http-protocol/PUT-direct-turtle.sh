#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S -X PUT \
     -H "Content-Type: application/turtle" \
     --data-binary @PUT.turtle \
     ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} \
 | fgrep -q "201"

rc=$?

if [[ "0" == "$rc" ]]
then
  curl -f -s -S -X GET\
       -H "Accept: application/n-quads" \
       ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} \
   | diff -q - PUT.nt > /dev/null ;
  rc=$?
fi

exit  $rc 


