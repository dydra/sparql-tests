#! /bin/bash

# verify response content type limits

curl -v -w "%{http_code}\n" -f -s -X GET\
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size?auth_token=${STORE_TOKEN} \
   | fgrep -q "406"

