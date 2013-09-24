#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} \
   | json_reformat -m \
   | fgrep '{"name":{"type":"literal","value":"mem-rdf"}' \
   | fgrep '"homepage":{"type":"literal","value":"http://example.org/test"}' \
   | fgrep '"summary":{"type":"literal","value":"a summary"}' \
   | fgrep '"description":{"type":"literal","value":"a description"}' \
   | fgrep -q '"license_url":{"type":"literal","value":"http://unlicense.org"}'


