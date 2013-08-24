#! /bin/sh


# test sesame rest interface
#
# environment :
# DYDRA_URL : host http url
# DYDRA_ACCOUNT : account name
# DYDRA_REPOSITORY : individual repository

export DYDRA_ACCOUNT="openrdf-sesame"
export DYDRA_REPOSITORY="mem-rdf"
ERRORS=0

# nb. the outer binding scope includes the loop for the "for in do" form,
# but not the "while read do" due to the pipe
#   find ./*/ -name '*.sh*' | while read file; do
# this limits the test complement to the number of arguments the shell permits

for file in `find ./*/ -name '*.sh*'`
do
  ( cd `dirname $file`;
    echo -n $file;
    bash `basename $file`;
  )
    if [[ $? == "0" ]]
    then
      echo "   ok"
    else
      echo "   failed";
      (( ERRORS = $ERRORS + 1))
      echo $ERRORS
    fi
done

if [[ "${ERRORS}" == "0" ]]
then
  echo "${ERRORS} errors."
fi

exit ${ERRORS}
