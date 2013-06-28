#! /bin/sh


# test provenance recording by checking the content of the related repository
# return 0 for success, otherwise 1
#
# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# TEST_LIBRARY : support scripts

source ${TEST_LIBRARY}/setup-script


run-query jhacker/726-provenance ${CLEAR_QUERY} > result-$$.srj && \
  test-result result-$$.srj provenance-1a-expected.srj && \
  run-query jhacker/726-base provenance-1b.rq > result-$$.srj && \
    test-result result-$$.srj provenance-1b-expected.srj && \
    run-query jhacker/726-provenance ${COUNT_QUERY} > result-$$.srj && \
    test-result result-$$.srj provenance-1c-expected.srj

STATUS=$?
exit $STATUS

