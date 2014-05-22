#! /bin/sh


# test that protocol slice limit returns the same results as that in the query
# even if it is overriding
# return 0 for success, otherwise 1
#
# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# TEST_LIBRARY : support scripts

source ${TEST_LIBRARY}/setup-script

run-query jhacker/basic-term-1 slice-limit.rq > slice-limit-result-1-$$.srj && \
  run-query jhacker/basic-term-1 slice-all.rq "limit=2" > slice-limit-result-2-$$.srj && \
    diff slice-limit-result-1-$$.srj slice-limit-result-2-$$.srj
STATUS=$?

if [ "$STATUS" = "0" ] 
then
  rm -f slice-limit-result-1-$$.srj slice-limit-result-2-$$.srj 
else
   mv slice-limit-result-1-$$.srj latest-slice-limit-result-1.srj
   if [ -e slice-limit-result-2-$$.srj ]
     then mv slice-limit-result-2-$$.srj latest-slice-limit-result-2.srj
     fi
fi

exit $STATUS
