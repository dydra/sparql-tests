#! /bin/sh


# test internal federation with an silent "self"-join;
# return 0 for success, otherwise 1
#
# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# TEST_LIBRARY : support scripts

source ${TEST_LIBRARY}/setup-script

run-query jhacker/basic-term-1 service07.rq > result-$$.srj && \
 test-result result-$$.srj service07-expected.srj
