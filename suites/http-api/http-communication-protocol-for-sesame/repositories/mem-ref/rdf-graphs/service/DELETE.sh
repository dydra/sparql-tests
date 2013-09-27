#! /bin/bash


curl -w "%{http_code}\n" -f -s -X DELETE \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/service?graph=${STORE_NAMED_GRAPH}\&auth_token=${STORE_TOKEN} \
   | fgrep -q "${DELETE_SUCCESS}"

initialize_repository | fgrep -q "${PUT_SUCCESS}"
