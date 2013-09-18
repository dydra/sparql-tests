#! /bin/bash

# test that delete with a graph removes just that content and leaves the default graph intact

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S -X DELETE\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN}\&graph=${STORE_NAMED_GRAPH} \
 | fgrep -q "204 OK"

if [[ "0" == "$rc" ]]
then
  curl -f -s -S -X GET\
       -H "Accept: application/n-quads" \
       ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} \
   | diff -q - GET-response.nt > /dev/null ;
  rc=$?
fi

exit  $rc 
