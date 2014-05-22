#! /bin/sh


# test external federation; the base repository is not material, just its access
# return 0 for success, otherwise 1
#
# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# TEST_LIBRARY : support scripts

source ${TEST_LIBRARY}/setup-script

run-query jhacker/basic-term-1 federation-external-1.rq > result-$$.srj && \
  test-result result-$$.srj federation-external-1-expected.srj

exit $?
