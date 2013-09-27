#! /bin/bash

# write privacy settings and test the immediate response;
# test the get response and then cycle back to the original state
#
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -H "Accept: " \
     --data-urlencode @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q "204"
_method=PUT&repository[default_repository_prefixes]=PREFIX xx: <http://xx.com> PREFIX yy: <http://zz.com> PREFIX zz2: <http://zz2.com>
EOF


curl -f -s -S -X GET \
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep '"xx":"http://xx.com"' | fgrep -v -q '"xsd":'

initialize_prefixes | fgrep -q "204"


curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep '"cc":"http://creativecommons.org/ns#"' | fgrep -q '"xsd":"http://www.w3.org/2001/XMLSchema#"'
