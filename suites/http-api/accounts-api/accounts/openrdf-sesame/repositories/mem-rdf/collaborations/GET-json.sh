#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

# have to allow that the collaboration record id changes
curl -f -s -S -X GET \
     -H "Accept: application/json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN} \
   | json_reformat -m \
   | fgrep '"account_name":"jhacker"' \
   | fgrep '"read":true' \
   | fgrep '"write":false' \
   | fgrep '"account":{"name":"jhacker"}' \
   | fgrep -q '"collaborator":"jhacker"'


