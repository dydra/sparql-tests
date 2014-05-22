#! /bin/bash

# url designators may not have the '<>' markers

curl -w "%{http_code}\n" -f -s -X GET \
     -H "Accept: application/n-triples" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/service?graph=\<http://dydra.com/graph-name\>\&auth_token=${STORE_TOKEN} \
   | fgrep -q "${STATUS_BAD_REQUEST}"

