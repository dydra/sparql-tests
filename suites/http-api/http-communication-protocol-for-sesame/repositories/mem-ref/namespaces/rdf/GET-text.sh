#! /bin/bash

# verify default response content type

curl -f -s -S -X GET\
     -H "Accept: text/plain" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/namespaces/rdf?auth_token=${DYDRA_TOKEN} \
   | fgrep -q 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'


