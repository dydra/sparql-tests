#! /bin/sh

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+xml" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories?auth_token=${DYDRA_TOKEN} \
 | xmllint --c14n11 - \
 | diff -q - GET-response.xml > /dev/null

