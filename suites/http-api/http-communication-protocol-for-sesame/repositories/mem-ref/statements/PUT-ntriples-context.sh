#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X PUT \
     -H "Content-Type: application/ntriples" \
     -d PUT-ntriples-context.nt
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/statements'?context=http://example.org' \
 | diff -q - PUT-ntriples-context-response.txt > /dev/null

