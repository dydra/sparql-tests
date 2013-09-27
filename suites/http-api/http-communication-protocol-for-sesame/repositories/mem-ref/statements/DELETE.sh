#! /bin/bash

# perform deletion, after which the retrieval has no content, but with a success code

curl -w "%{http_code}\n" -f -s -S -X DELETE \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?auth_token=${STORE_TOKEN} \
   | fgrep -q "${DELETE_SUCCESS}"


curl -f -s -S -X GET \
     -H "Accept: application/n-triples" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements?auth_token=${STORE_TOKEN} \
   | wc -l | fgrep -q "0"


initialize_repository | fgrep -q "${PUT_SUCCESS}"