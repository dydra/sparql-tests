#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S --head\
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY}-not?auth_token=${STORE_TOKEN} \
 | fgrep -q "404"
