#! /bin/bash

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url
# STORE_TOKEN : authentication token

# if local, then the public-ip results apply
if $STORE_IS_LOCAL
then
  exit 0;
fi

curl -f -s -S -X GET \
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/${STORE_ACCOUNT}/repositories \
   | json_reformat -m \
   | fgrep '"value":"public"' \
   | tr -s ':' '\n' | fgrep -c 'readable' | fgrep -q '2'
