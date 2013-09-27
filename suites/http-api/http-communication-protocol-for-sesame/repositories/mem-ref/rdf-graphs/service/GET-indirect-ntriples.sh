#! /bin/bash

# yields just the single statement in the named graph, but without the context

curl -f -s -S -X GET\
     -H "Accept: application/n-triples" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/service?graph=http://dydra.com/graph-name\&auth_token=${STORE_TOKEN} \
   | tr -s '\n' '\t' \
   | fgrep '"named object"' | fgrep -v "${STORE_NAMED_GRAPH}" \
   | tr -s '\t' '\n' | wc -l | fgrep -q 1
