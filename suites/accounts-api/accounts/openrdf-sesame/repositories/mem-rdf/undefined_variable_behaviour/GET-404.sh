#! /bin/bash

# the repository has no setting unless supplied here. thus the 404
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -X GET \
     -w "%{http_code}\n" -f -s \
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/undefined_variable_behaviour?auth_token=${STORE_TOKEN} \
   | fgrep -q 404

