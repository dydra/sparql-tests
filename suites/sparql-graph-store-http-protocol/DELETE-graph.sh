#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X DELETE \
     $DYDRA_URL/${DYDRA_ACCOUNT}/${DYDRA_REPOSITORY}/example \
 | diff -q - DELETE-graph-response.txt > /dev/null

