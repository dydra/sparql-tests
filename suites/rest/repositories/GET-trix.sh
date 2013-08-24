#! /bin/sh

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 


curl -f -s -S -X GET\
     -H "Accept: application/trix" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories \
 | diff - GET-trix-response.trix

