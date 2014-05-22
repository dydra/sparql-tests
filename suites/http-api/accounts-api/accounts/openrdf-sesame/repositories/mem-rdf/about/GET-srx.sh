#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+xml" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} \
   | xmllint --c14n11 - \
   | tr -d ' \t\n\r\f' \
   | fgrep '<bindingname="name"><literal>mem-rdf</literal>' \
   | fgrep '<bindingname="homepage"><literal>http://example.org/test</literal>' \
   | fgrep '<bindingname="summary"><literal>asummary</literal>' \
   | fgrep '<bindingname="description"><literal>adescription</literal>' \
   | fgrep -q '<bindingname="license_url"><literal>http://unlicense.org</literal></binding>'