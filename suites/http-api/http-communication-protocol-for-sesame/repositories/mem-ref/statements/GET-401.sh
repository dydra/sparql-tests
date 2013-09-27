#! /bin/bash


curl -w "%{http_code}\n" -f -s -X GET\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements \
 | fgrep -q '401'

