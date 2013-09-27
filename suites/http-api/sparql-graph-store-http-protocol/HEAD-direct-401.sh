#! /bin/bash

# test that improper authentication yields a 401

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -w "%{http_code}\n" -f -s -S --head\
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY} \
 | fgrep -q "401"
