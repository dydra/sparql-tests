#! /bin/sh

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/rdf+xml" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories \
 | diff -q - GET-rdf+xml-response.xml > /dev/null

