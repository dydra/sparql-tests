#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET \
     -H "Accept: application/sparql-results+xml" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN} \
  | xmllint --c14n11 - \
  | tr -d ' \t\n\r\f' \
  | fgrep '<bindingname="account_name"><literal>jhacker</literal>' \
  | fgrep '<bindingname="read"><literal>1</literal>' \
  | fgrep -q '<bindingname="write"><literal/>'


