#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url
# STORE_TOKEN : authentication token

# if not local, then the public results apply
if ! $STORE_IS_LOCAL
then
  exit 0;
fi

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/${STORE_ACCOUNT}/repositories \
   | json_reformat -m \
   | fgrep '"value":"public"' \
   | fgrep '"value":"public-ip"' \
   | tr -s ':' '\n' | fgrep -c 'readable' | fgrep -q '3'
