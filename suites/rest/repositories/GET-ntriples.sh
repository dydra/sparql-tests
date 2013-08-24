#! /bin/sh

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 


curl -f -s -S -X GET\
     -H "Accept: application/ntriples" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories \
 | diff - GET-triples-response.nt
