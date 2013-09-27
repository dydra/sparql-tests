#! /bin/bash

# yields just the single statement in the named graph

curl -f -s -S -X GET \
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/service?graph=${STORE_NAMED_GRAPH}\&auth_token=${STORE_TOKEN} \
   | tr -s '\n' '\t' \
   | fgrep '"named object"' | fgrep "${STORE_NAMED_GRAPH}" \
   | tr -s '\t' '\n' | wc -l | fgrep -q 1
