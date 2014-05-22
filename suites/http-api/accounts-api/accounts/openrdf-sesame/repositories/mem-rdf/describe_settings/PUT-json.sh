#! /bin/bash

# write describe settings with value coercion;
# test the get response and then cycle back to the original empty state
#
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -S -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/describe_settings?auth_token=${STORE_TOKEN} <<EOF \
 | json_reformat -m  \
 | fgrep '"describe_form":"urn:rdfcache:simple-symmetric-concise-bounded-description"' \
 | fgrep '"describe_object_depth":1' \
 | fgrep -q '"describe_subject_depth":1'
{"describe_form":"urn:rdfcache:simple-symmetric-concise-bounded-description","describe_object_depth":1,"describe_subject_depth":"1"}
EOF


curl -f -s -S -X GET\
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/describe_settings?auth_token=${STORE_TOKEN} \
  | json_reformat -m  \
 | fgrep '"describe_form":"urn:rdfcache:simple-symmetric-concise-bounded-description"' \
 | fgrep '"describe_object_depth":1' \
 | fgrep -q '"describe_subject_depth":1'


curl -w "%{http_code}\n" -f -s -X DELETE \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/describe_settings?auth_token=${STORE_TOKEN} \
 | fgrep -q "204"


curl -X GET \
     -w "%{http_code}\n" -f -s \
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/describe_settings?auth_token=${STORE_TOKEN} \
 | fgrep -q "404"
