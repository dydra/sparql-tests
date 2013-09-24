#! /bin/bash

# cycle various about setting and test success
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} <<EOF \
   | fgrep 'null' | wc | fgrep -q " 4 "
{
    "name": "mem-rdf",
    "homepage": null,
    "summary": null,
    "description": null,
    "license_url": null
}
EOF


initialize_about | fgrep -q 204


curl -f -s -S -X GET \
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} \
   | json_reformat -m \
   | fgrep '"name":"mem-rdf"' \
   | fgrep '"homepage":"http://example.org/test"' \
   | fgrep '"summary":"a summary"' \
   | fgrep '"description":"a description"' \
   | fgrep -q '"license_url":"http://unlicense.org"'
