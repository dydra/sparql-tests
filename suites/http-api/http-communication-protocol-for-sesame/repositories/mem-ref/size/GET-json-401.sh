#! /bin/bash

# verify response content type limits

curl -w "%{http_code}\n" -f -s -X GET \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size \
   | fgrep -q "401"


