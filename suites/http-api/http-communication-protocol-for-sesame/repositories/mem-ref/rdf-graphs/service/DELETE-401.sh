#! /bin/bash

curl -w "%{http_code}\n" -f -s -X DELETE \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/service?graph=${STORE_NAMED_GRAPH} \
   | fgrep -q "${STATUS_UNAUTHORIZED}"

