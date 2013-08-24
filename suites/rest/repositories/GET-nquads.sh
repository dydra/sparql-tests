#! /bin/sh

# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# TEST_LIBRARY : support scripts


curl -f -s -S -X GET\
     -H "Accept: application/nquads" \
     $DYDRA_URL/openrdf-sesame/repositories \
 | diff - GET-nquads-response.nq

