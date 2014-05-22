#! /bin/bash

curl -w "%{http_code}\n" -f -s -X GET \
     -H "Accept: text/plain" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size?auth_token=${STORE_TOKEN}\&context=${STORE_NAMED_GRAPH}-not \
   | fgrep -q '404'

