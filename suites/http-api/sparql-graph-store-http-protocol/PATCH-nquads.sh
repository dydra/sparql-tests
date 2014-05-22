#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -S -X PATCH \
     -H "Content-Type: application/n-quads" \
     --data-binary @PATCH.nq
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY} \
 | diff -q - PATCH-nquads-response.txt > /dev/null

