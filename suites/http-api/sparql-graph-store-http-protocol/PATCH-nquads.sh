#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X PATCH \
     -H "Content-Type: application/nquads" \
     -d PATCH-nquads.nquads
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY} \
 | diff -q - PATCH-nquads-response.txt > /dev/null

