#! /bin/bash

# test that a non-existent repository yields a 404

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S -X DELETE\
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY}-not?auth_token=${STORE_TOKEN} \
 | fgrep -q "404"

