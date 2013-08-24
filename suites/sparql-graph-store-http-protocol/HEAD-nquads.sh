#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X HEAD \
     -H "Content-Type: application/nquads" \
     -d PUT-nquads.nquads
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/rdf-graphs/default \
 | diff -q - HEAD-nquads-response.txt > /dev/null

