#! /bin/bash

# the protocol target is an indirect graph, the statements include quads and the content type is n-quads:
# - triples are added to the _default_ graph.
# - quads are added to the document graph.
# - no statements are removed

curl -w "%{http_code}\n" -f -s -S -X POST \
     -H "Content-Type: application/n-quads" \
     --data-binary @- \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?context=${STORE_NAMED_GRAPH}-three\&auth_token=${STORE_TOKEN} <<EOF \
   | fgrep -q "${POST_SUCCESS}"
<http://example.com/default-subject> <http://example.com/default-predicate> "default object rdf-graphs POST1" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object rdf-graphs POST1" <${STORE_NAMED_GRAPH}-two> .
EOF


curl -f -s -S -X GET\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?auth_token=${STORE_TOKEN} \
   | tr -s '\n' '\t' \
   | fgrep '"default object"' | fgrep '"named object"' | fgrep  "<${STORE_NAMED_GRAPH}>" \
   | fgrep '"default object rdf-graphs POST1"' | fgrep '"named object rdf-graphs POST1"' | fgrep  "<${STORE_NAMED_GRAPH}-two>" \
   | tr -s '\t' '\n' | wc -l | fgrep -q 4


curl -w "%{http_code}\n" -f -s -S -X POST \
     -H "Content-Type: application/n-quads" \
     --data-binary @- \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?context=${STORE_NAMED_GRAPH}-three\&auth_token=${STORE_TOKEN} <<EOF \
  | fgrep -q "${POST_SUCCESS}"
<http://example.com/default-subject> <http://example.com/default-predicate> "default object rdf-graphs POST2" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object rdf-graphs POST2" <${STORE_NAMED_GRAPH}-two> .
EOF


curl -f -s -S -X GET\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?auth_token=${STORE_TOKEN} \
   | tr -s '\n' '\t' \
   | fgrep '"default object"' | fgrep '"named object"' | fgrep  "<${STORE_NAMED_GRAPH}>" \
   | fgrep '"default object rdf-graphs POST1"' | fgrep '"named object rdf-graphs POST1"' \
   | fgrep '"default object rdf-graphs POST2"' | fgrep '"named object rdf-graphs POST2"' | fgrep  "<${STORE_NAMED_GRAPH}-two>" \
   | tr -s '\t' '\n' | wc -l | fgrep -q 6

initialize_repository | fgrep -q "${POST_SUCCESS}"
