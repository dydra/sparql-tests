#! /bin/bash

# verify the presence of a single named graph in the response

curl -f -s -S -X GET \
     -H "Accept: application/sparql-results+xml" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/contexts \
   | xmllint  --c14n11 - \
   | tr -s '\t\n\r\f' ' ' | sed 's/ +/ /g' \
   | egrep -s '<binding name="contextID"> <uri>http://dydra.com/graph-name</uri>' \
   | tr -s '=' '\n' | fgrep -c 'contextID' | fgrep -q '2'

