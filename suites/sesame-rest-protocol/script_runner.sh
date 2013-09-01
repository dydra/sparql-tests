#! /bin/bash


# test sesame rest interface
#
# environment :
# DYDRA_URL : host http url
# DYDRA_ACCOUNT : account name
# DYDRA_REPOSITORY : individual repository

export DYDRA_HOST=${DYDRA_URL:7}
export DYDRA_ACCOUNT="openrdf-sesame"
export DYDRA_REPOSITORY="mem-rdf"
export DYDRA_TOKEN=`cat ~/.dydra/token-$(DYDRA_ACCOUNT}`
export DYDRA_IS_LOCAL=false
fgrep 127.0.0.1 /etc/hosts | fgrep -q ${DYDRA_HOST}
if [[ "$?" == "0" ]]
then
  export DYDRA_IS_LOCAL=true
fi
DYDRA_ERRORS=0
WD=`pwd`


initialize_repository () {
    curl -f -s -S -X PUT \
     -H "Content-Type: application/n-quads" --data-binary @${WD}/PUT.nq \
     ${DYDRA_URL}/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/statements?auth_token=${DYDRA_TOKEN} 
}

# nb. the outer binding scope includes the loop for the "for in do" form,
# but not the "while read do" due to the pipe
#   find ./*/ -name '*.sh*' | while read file; do
# this limits the test complement to the number of arguments the shell permits

SCRIPTS="$1"
if [[ "${SCRIPTS}" == "" ]]
then
  SCRIPTS=`find ./*/ -name '*.sh*'`
fi

for script_pathname in $SCRIPTS
do
  echo -n $script_pathname;
  script_filename=`basename $script_pathname`
  script_directory=`dirname $script_pathname`
  ( cd $script_directory;
    bash $script_filename;
  )
  if [[ $? == "0" ]]
  then
    echo "   ok"
  else
    echo "   failed";
    (( DYDRA_ERRORS = $DYDRA_ERRORS + 1))
    echo $DYDRA_ERRORS
  fi
  if [[ ! "${script_filename:0:4}" == "GET-" ]]
  then
    initialize_repository
  fi
done

if [[ "${DYDRA_ERRORS}" == "0" ]]
then
  echo "${DYDRA_ERRORS} errors"
fi

exit ${DYDRA_ERRORS}
