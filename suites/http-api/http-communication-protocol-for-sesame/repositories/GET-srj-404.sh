#! /bin/bash

# verify that unauthorized access fails
curl -w "%{http_code}\n" -f -s -X GET\
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/${STORE_ACCOUNT}-not/repositories \
   | fgrep -q 404

