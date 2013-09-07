#! /bin/bash

# test get, but authenticate as jhacker, which should 
# if remote, authorize just public-authenticated repositories, but
# if local, authorize both public-authenticated and private-ip repositories

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url
# DYDRA_TOKEN : authentication token

# if local, then the public-ip results apply
if $DYDRA_IS_LOCAL
then
  exit 0;
fi

DYDRA_TOKEN_JHACKER=`cat ~/.dydra/token-jhacker`
curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories?auth_token=${DYDRA_TOKEN_JHACKER} \
 | json_reformat -m | diff -q - ${DYDRA_RESULT} > /dev/null

