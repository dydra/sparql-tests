#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET \
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} \
   | json_reformat -m \
   | fgrep '"name":"mem-rdf"' \
   | fgrep '"homepage":"http://example.org/test"' \
   | fgrep '"summary":"a summary"' \
   | fgrep '"description":"a description"' \
   | fgrep -q '"license_url":"http://unlicense.org"'