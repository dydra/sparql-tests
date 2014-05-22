#! /bin/bash

# the protocol target is a direct graph, the statements include quads and the content type is n-quads:
# - triples are added to the _default_ graph.
# - quads are added to the document graph.
# - no statements are removed

curl -w "%{http_code}\n" -f -s -X POST \
     -H "Content-Type: application/not-n-quads" \
     --data-binary @- \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/sesame?auth_token=${STORE_TOKEN} <<EOF \
   | fgrep -q "${STATUS_UNSUPPORTED_MEDIA}"
<http://example.com/default-subject> <http://example.com/default-predicate> "default object rdf-graphs POST1" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object rdf-graphs POST1" <${STORE_NAMED_GRAPH}-two> .
EOF
