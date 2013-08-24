#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X POST \
     -H "Content-Type: application/n-triples" \
     -d POST-ntriples-context.nt
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/statements'?context=http://example.org' \
 | diff -q - POST-ntriples-context-response.txt > /dev/null

