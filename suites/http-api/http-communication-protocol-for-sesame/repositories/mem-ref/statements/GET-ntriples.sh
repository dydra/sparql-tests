#! /bin/bash


curl -f -s -S -X GET\
     -H "Accept: application/ntriples" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements \
   | fgrep -v "{STORE_NAMED_GRAPH}" \
   | wc -l | fgrep -q 2

