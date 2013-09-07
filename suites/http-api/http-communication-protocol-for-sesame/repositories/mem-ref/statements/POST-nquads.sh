#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X POST \
     -H "Content-Type: application/n-quads" \
     -d POST-nquads.nq \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/statements \
 | diff -q - POST-nquads-response.txt > /dev/null

