#! /bin/bash

# verify the presence of exactly one named graph in the result
curl -f -s -S -X GET \
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/contexts?auth_token=${STORE_TOKEN} \
   | json_reformat -m \
   | fgrep 'contextID' | fgrep '"value":"http://dydra.com/graph-name"' \
   | tr -s ':' '\n' | fgrep -c 'contextID' | fgrep -q '2'
