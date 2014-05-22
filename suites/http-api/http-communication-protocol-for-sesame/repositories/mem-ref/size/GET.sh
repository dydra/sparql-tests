#! /bin/bash

# verify the two statement count of the initialized repository

curl -f -s -S -X GET \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/size?auth_token=${STORE_TOKEN} \
 | fgrep -q '2'


