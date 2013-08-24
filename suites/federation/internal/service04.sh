#! /bin/sh


# test internal federation with an optional "self"-join with bindings;
# the dawg manifest/results imply that the bindings are pushed to the service, but that
# contradicts the outer join semantics.
#
# return 0 for success, otherwise 1
#
# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# TEST_LIBRARY : support scripts

source ${TEST_LIBRARY}/setup-script

run-query jhacker/basic-term-1 service04.rq > result-$$.srj && \
 test-result result-$$.srj service04-expected.srj
