#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

# nb. this does not test the cumulative aspects of the request

curl -f -s -S -X POST \
     -H "Content-Type: application/n-quads" \
     --data-binary @POST.nq \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/rdf-graphs/sesame?auth_token=${DYDRA_TOKEN} \
 | diff -q - POST-response.nq > /dev/null

rc=$?

if [[ "0" == "$rc" ]]
then
  curl -f -s -S -X GET\
       -H "Accept: application/n-quads" \
       $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/rdf-graphs/sesame?auth_token=${DYDRA_TOKEN} \
   | diff -q - GET-response.nq > /dev/null
  #rc=$?
fi
exit ( $rc )