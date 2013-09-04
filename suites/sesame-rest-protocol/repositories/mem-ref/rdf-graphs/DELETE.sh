#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X DELETE \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/rdf-graphs/sesame?auth_token=${DYDRA_TOKEN} \
 | diff -q - DELETE-response.txt > /dev/null

