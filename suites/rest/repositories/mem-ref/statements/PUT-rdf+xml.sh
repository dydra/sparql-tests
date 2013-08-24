#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X PUT \
     -H "Content-Type: application/rdf+xml" \
     -d PUT-rdfxml.xml
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/statements \
 | diff -q - PUT-rdfxml-response.txt > /dev/null

