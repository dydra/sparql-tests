#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+xml" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/namespaces?auth_token=${DYDRA_TOKEN} \
 | xmllint  --c14n11 - \
 | diff -q - GET-rdfxml-response.mxl > /dev/null

