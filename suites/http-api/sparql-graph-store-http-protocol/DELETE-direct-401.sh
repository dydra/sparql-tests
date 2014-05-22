#! /bin/bash

# test that improper authentication yields a 401

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl 
 -f -s -S -X DELETE\
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN}-not \
 | fgrep -q "401"

