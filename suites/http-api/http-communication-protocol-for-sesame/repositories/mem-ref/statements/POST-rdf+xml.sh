#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X POST \
     -H "Content-Type: application/rdf+xml" \
     -d POST-rdfxml.xml
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/statements \
 | diff -q - POST-rdfxml-response.txt > /dev/null

