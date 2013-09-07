#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url
# DYDRA_TOKEN : authentication token

# verify that unauthorized access fails
curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories 2>/dev/stdout \
   | fgrep -q 'error: 401'

