#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+xml" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} \
  | xmllint --c14n11 - \
  | tr -d ' \t\n\r\f' \
  | fgrep '<bindingname="prefix"><literal>cc</literal></binding><bindingname="namespace"><literal>http://creativecommons.org/ns#</literal></binding>' \
  | fgrep -q '<bindingname="prefix"><literal>xsd</literal></binding><bindingname="namespace"><literal>http://www.w3.org/2001/XMLSchema#</literal></binding>'
