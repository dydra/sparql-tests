#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S -X POST \
     -H "Content-Type: application/n-quads" \
     --data-binary @PUT.nq \
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN}\&graph=${STORE_IGRAPH} \
 | fgrep -q "201"

if [[ "0" == "$rc" ]]
then
  curl -f -s -S -X GET\
       -H "Accept: application/n-quads" \
       ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} \
   | diff -q - POST-graph-nquads-GET-response.nq > /dev/null ;
  rc=$?
fi

exit  $rc 
