#! /bin/bash

# test validity constraint
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -X PUT \
     -w "%{http_code}\n" -f -s \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/describe_settings?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q 400
{"describe_form":"urn:rdfcache:simple-symmetric-concise-bounded-description-not","describe_object_depth":1,"describe_subject_depth":"1"}
EOF


curl -X PUT \
     -w "%{http_code}\n" -f -s \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/describe_settings?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q 400
{"describe_form":"urn:rdfcache:simple-concise-bounded-description","describe_object_depth":"a","describe_subject_depth":"1"}
EOF


curl -X PUT \
     -w "%{http_code}\n" -f -s \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/describe_settings?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q 400
{"describe_form":"urn:rdfcache:simple-inverse-concise-bounded-description","describe_object_depth":1,"describe_subject_depth":"a"}
EOF


curl -w "%{http_code}\n" -f -s -X DELETE \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/describe_settings?auth_token=${STORE_TOKEN} \
 | fgrep -q "204"
