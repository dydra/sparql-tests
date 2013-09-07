#! /bin/bash

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url
# DYDRA_TOKEN : authentication token

# if not local, then the public results apply
if ! $DYDRA_IS_LOCAL
then
  exit 0;
fi

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories \
 | json_reformat | diff -q - GET-response-public-ip.json > /dev/null

