#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -S --head\
     $STORE_URL/${STORE_ACCOUNT}/${STORE_REPOSITORY_PUBLIC} \
 | fgrep -q "200 OK"

