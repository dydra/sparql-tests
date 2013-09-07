#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S -X POST \
     -H "Content-Type: application/n-triples" \
     --data-binary @PUT.nt \
     $DYDRA_URL/${DYDRA_ACCOUNT}/${DYDRA_REPOSITORY}?auth_token=${STORE_TOKEN}\&graph=default \
 | fgrep -q "201"


if [[ "0" == "$rc" ]]
then
  curl -f -s -S -X GET\
       -H "Accept: application/n-quads" \
       ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} \
   | diff -q - POST-default-ntriples-GET-response.nt > /dev/null ;
  rc=$?
fi

exit  $rc 
