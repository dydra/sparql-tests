#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 

curl -f -s -S -X GET\
     -H "Accept: text/plain" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/protocol \
 | fgrep -q '6'


