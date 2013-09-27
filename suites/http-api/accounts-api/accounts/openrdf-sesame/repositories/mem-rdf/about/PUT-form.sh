#! /bin/bash

# cycle various about setting and test success
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/x-www-form-urlencoded" \
     --data-urlencode @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN}<<EOF \
 | fgrep -q "204"
_method=PUT&repository[summary]=three word summary&repository[license_url]=http://creativecommons.org/publicdomain/zero/1.0
EOF


curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep mem-rdf | fgrep commons | fgrep -q three


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
