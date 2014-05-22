#! /bin/bash

# verify that text/plain is processed as application/n-triples


curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: text/plain" \
     --data-binary @- \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/sesame?auth_token=${STORE_TOKEN} <<EOF \
   | fgrep -q "${PUT_SUCCESS}"
<http://example.com/default-subject> <http://example.com/default-predicate> "default object rdf-graphs PUT1" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object rdf-graphs PUT1" <${STORE_NAMED_GRAPH}-two> .
EOF


curl -f -s -S -X GET\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?auth_token=${STORE_TOKEN} \
   | tr -s '\n' '\t' \
   | fgrep '"default object"' | fgrep '"named object"' | fgrep  "<${STORE_NAMED_GRAPH}>" \
   | fgrep -v "<${STORE_NAMED_GRAPH}-two>" \
   | tr -s '\t' '\n' | fgrep 'rdf-graphs/sesame' | wc -l | fgrep -q 2

initialize_repository | fgrep -q "${PUT_SUCCESS}"
