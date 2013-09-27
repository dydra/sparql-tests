#! /bin/bash

# context=null yields just the default rgaph content

curl -f -s -S -X GET\
     -H "Accept: application/n-quads" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?context=null\&auth_token=${STORE_TOKEN} \
   | fgrep '"default object"' \
   | fgrep -v '"named object"' \
   | wc -l | fgrep -q 1

