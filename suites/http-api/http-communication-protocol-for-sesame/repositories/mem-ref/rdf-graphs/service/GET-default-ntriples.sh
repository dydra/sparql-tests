#! /bin/bash

# yields just the single statement in the default graph

curl -f -s -S -X GET\
     -H "Accept: application/n-triples" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/service?graph=default\&auth_token=${STORE_TOKEN} \
   | tr -s '\n' '\t' \
   | fgrep '"default object"'\
   | tr -s '\t' '\n' | wc -l | fgrep -q 1
