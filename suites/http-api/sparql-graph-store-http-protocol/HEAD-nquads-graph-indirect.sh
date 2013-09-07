#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository

curl -f -s -S -X HEAD \
     -H "Accept: application/nquads" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}'?graph='$DYDRA_URL/${DYDRA_ACCOUNT}/${DYDRA_REPOSITORY}/example \
 | diff -q - HEAD-nquads-response.nq > /dev/null

