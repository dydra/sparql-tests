#! /bin/bash


curl -w "%{http_code}\n"  -f -s -S -X GET\
     -H "Accept: application/rdf+json" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?auth_token=${STORE_TOKEN} \
   | fgrep -q "${STATUS_NOT_ACCEPTABLE}"

echo -n " NYI "