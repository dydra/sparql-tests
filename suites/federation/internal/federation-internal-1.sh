#! /bin/sh


# test internal federation; the base repository is not material, just its access
# return 0 for success, otherwise 1
#
# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# TEST_LIBRARY : support scripts

source ${TEST_LIBRARY}/setup-script

run-query jhacker/basic-term-1 federation-internal-1.rq > result-$$.srj
RESULT=$?
if [ $RESULT == 0 ]
then
  test-result result-$$.srj federation-internal-1-expected.srj
  RESULT=$?
fi
exit $RESULT
