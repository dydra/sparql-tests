#! /bin/bash

# test get, but authenticate as jhacker, which should authorize just public-authenticated repositories

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url
# DYDRA_TOKEN : authentication token

# if not local, then the private results apply
if ! $DYDRA_IS_LOCAL
then
  exit 0;
fi

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     ${DYDRA_URL}/${DYDRA_ACCOUNT}/repositories \
 | json_reformat -m | diff -q - GET-response-private-ip.json > /dev/null

