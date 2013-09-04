#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S -X PUT \
     -H "Content-Type: application/n-triples" \
     --data-binary @PUT.nt \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/rdf-graphs/sesame?auth_token=${DYDRA_TOKEN} \
 | fgrep -q "201"

rc=$?

if [[ "0" == "$rc" ]]
  curl -f -s -S -X GET\
       -H "Accept: application/n-quads" \
       $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/rdf-graphs/sesame?auth_token=${DYDRA_TOKEN} \
   | diff -q - PUT-GET-response.nq > /dev/null
  rc=$?
fi
exit ( $rc )
