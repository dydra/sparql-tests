#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+xml" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} \
  | xmllint --c14n11 - \
  | tr -d ' \t\n\r\f' \
  | fgrep '<bindingname="privacy_setting"><literal>1</literal></binding>' \
  | fgrep -q '<bindingname="permissable_ip_addresses"><literal>192.168.1.1</literal></binding>'
