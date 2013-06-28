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

run-query jhacker/basic-term-1 slice-offset.rq > slice-offset-result-1-$$.srj && \
  run-query jhacker/basic-term-1 slice-all.rq  "offset=2" > slice-offset-result-2-$$.srj && \
    diff slice-offset-result-1-$$.srj slice-offset-result-2-$$.srj
RESULT=$?
if [ "$RESULT" = "0" ] 
then
  rm -r slice-offset-result-1-$$.srj slice-offset-result-2-$$.srj
else
  mv slice-offset-result-1-$$.srj latest-slice-offset-result-1.srj
  if [ -e slice-offset-result-2-$$.srj ]
  then mv slice-offset-result-2-$$.srj latest-slice-offset-result-2.srj
  fi
fi

exit $RESULT
