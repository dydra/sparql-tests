#! /bin/sh


# test that procol limit offset returns the same results as that in the query
# even if it is overriding
# return 0 for success, otherwise 1
#
# environment :
# DYDRA_ACCOUNT : account name
# DYDRA_URL : host http url 
# TEST_LIBRARY : support scripts

source ${TEST_LIBRARY}/setup-script

run-query jhacker/basic-term-1 slice-limit-offset.rq > slice-limit-offset-result-1-$$.srj && \
  run-query jhacker/basic-term-1 slice-all.rq  "limit=2&offset=2" > slice-limit-offset-result-2-$$.srj && \
    diff slice-limit-offset-result-1-$$.srj slice-limit-offset-result-2-$$.srj
RESULT=$?
if [ "$RESULT" = "0" ] 
then
  rm -r slice-limit-offset-result-1-$$.srj slice-limit-offset-result-2-$$.srj
else
  mv slice-limit-offset-result-1-$$.srj latest-slice-limit-offset-result-1.srj
  if [ -e slice-limit-offset-result-2-$$.srj ]
  then mv slice-limit-offset-result-2-$$.srj latest-slice-limit-offset-result-2.srj
  fi
fi

exit $RESULT
