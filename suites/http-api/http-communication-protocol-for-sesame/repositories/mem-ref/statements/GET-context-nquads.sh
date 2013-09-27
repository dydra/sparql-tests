#! /bin/bash

# context=%3C${STORE_NAMED_GRAPH}%3E yields just the named graph content

curl -f -s -S -X GET\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?context=%3C${STORE_NAMED_GRAPH}%3E\&auth_token=${STORE_TOKEN} \
   | fgrep -v '"default object"' \
   | fgrep '"named object"' \
   | wc -l | fgrep -q 1


