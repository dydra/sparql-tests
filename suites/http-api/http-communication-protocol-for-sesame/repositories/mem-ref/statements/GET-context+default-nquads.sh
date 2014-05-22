#! /bin/bash

# context=null\&context=%3C${STORE_NAMED_GRAPH}%3E yields both default and named graph content

curl -f -s -S -X GET\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?context=%3C${STORE_NAMED_GRAPH}%3E\&context=null\&auth_token=${STORE_TOKEN} \
   | wc -l | fgrep -q 2


