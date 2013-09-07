#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X PUT \
     -H "Content-Type: application/n-quads" \
     --data-binary @PUT.nq \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/rdf-graphs/service?graph=$DYDRA_URL/${DYDRA_ACCOUNT}/${DYDRA_REPOSITORY}\&auth_token=${DYDRA_TOKEN} \
 | diff -q - PUT-nquads-response.txt > /dev/null

