#! /bin/bash

# use both a named context and the "special value null"
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: text/plain" \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size?auth_token=${STORE_TOKEN}\&context=null\&context=${STORE_NAMED_GRAPH} \
   | fgrep -q '2'

