#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X GET\
     -H "Accept: application/n-quads" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/rdf-graphs/service?auth_token=${DYDRA_TOKEN}\&graph=\<http://dydra.com/graph-name\> \
 | diff -q - GET-response.nq > /dev/null

