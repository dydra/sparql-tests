#! /bin/bash


curl -f -s -S -X GET\
     -H "Accept: application/rdf+xml" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?auth_token=${STORE_TOKEN} \
   | xmllint --c14n11 - | tr -s '\t\n\r\f' ' ' \
   | fgrep "default object" \
   | fgrep -q "named object"
