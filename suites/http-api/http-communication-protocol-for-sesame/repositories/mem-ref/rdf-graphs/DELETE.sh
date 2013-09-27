#! /bin/bash

# add a direct sesame graph and then delete it

initialize_repository_rdf_graphs | fgrep -q "${PUT_SUCCESS}"

curl -f -s -S -X GET \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size?auth_token=${STORE_TOKEN} \
 | fgrep -q '3'


curl -w "%{http_code}\n" -f -s -X DELETE \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/sesame?auth_token=${STORE_TOKEN} \
 | fgrep -q 204


curl -f -s -S -X GET \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size?auth_token=${STORE_TOKEN} \
 | fgrep -q '2'

initialize_repository | fgrep -q "${PUT_SUCCESS}"

