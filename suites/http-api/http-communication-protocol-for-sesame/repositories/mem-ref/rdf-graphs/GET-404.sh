#! /bin/bash


# verify the 404 response for a non-existant graph

curl -w "%{http_code}\n" -f -s -X GET \
     -H "Accept: application/n-triples" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/not-there?auth_token=${STORE_TOKEN} \
 | fgrep -q '404'

