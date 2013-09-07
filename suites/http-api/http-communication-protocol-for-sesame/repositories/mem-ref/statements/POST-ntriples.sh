#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X POST \
     -H "Content-Type: application/n-triples" \
     -d POST-ntriples.nt
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/statements \
 | diff -q - POST-ntriples-response.txt > /dev/null

