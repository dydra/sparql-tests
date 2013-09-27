#! /bin/bash

# test get, but authenticate as jhacker, which should 
# if remote, authorize just public-authenticated repositories, but
# if local, authorize both public-authenticated and private-ip repositories

# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url
# STORE_TOKEN : authentication token

# if local, then the public-ip results apply
if $STORE_IS_LOCAL
then
  exit 0;
fi

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/${STORE_ACCOUNT}/repositories?auth_token=${STORE_TOKEN_JHACKER} \
  | json_reformat -m \
  | fgrep '"value":"public-authenticated"' \
  | fgrep '"value":"mem-rdf"' \
  | fgrep '"value":"public"' \
  | tr -s ':' '\n' | fgrep -c 'readable' | fgrep -q '4'
