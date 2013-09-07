#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# DYDRA_REPOSITORY : individual repository
# DYDRA_TOKEN : authentication token

curl -f -s -S -X GET \
     -H "Accept: application/sparql-results+json" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/contexts?auth_token=${DYDRA_TOKEN} \
 | json_reformat -m \
 | diff -q - GET-response.json > /dev/null

