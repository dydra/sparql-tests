#! /bin/bash

# verify response content type limits

curl -w "%{http_code}\n" -f -s -S -X GET \
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/namespaces/rdf?auth_token=${STORE_TOKEN} \
   | fgrep -q "406"

