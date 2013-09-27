#! /bin/bash

# verify the single statement count of the named graph in the initialized repository


curl -f -s -S -X GET\
     -H "Accept: text/plain" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size?auth_token=${STORE_TOKEN}\&context=${STORE_NAMED_GRAPH} \
   | fgrep -q '1'

