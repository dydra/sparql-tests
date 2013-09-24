#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} \
  | json_reformat -m | fgrep '"cc":"http://creativecommons.org/ns#"' | fgrep -q 'xsd":"http://www.w3.org/2001/XMLSchema#"'


