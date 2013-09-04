#! /bin/bash


# http api tests
#
# environment :
# DYDRA_URL : host http url
# DYDRA_ACCOUNT : account name
# DYDRA_REPOSITORY : individual repository
# DYDRA_TOKEN : the authentication token
if [[ "" == "${DYDRA_URL}" ]]
then
  export DYDRA_URL="http://localhost"
if
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

cat > /tmp/PUT.nq <<EOF
<http://example.com/default-subject> <http://example.com/default-predicate> "default object" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object" <http://dydra.com/graph-name> .
EOF

# provide an operator to restore the store to a known state
# it presumes, that the statements PUT operator works
initialize_repository () {
    curl -L -f -s -S -X PUT \
     -H "Content-Type: application/n-quads" --data-binary @/tmp/PUT.nq \
     ${DYDRA_URL}/${DYDRA_ACCOUNT}/${DYDRA_REPOSITORY}?auth_token=${DYDRA_TOKEN} 
}

# iterate over all '.sh' scripts in the current wd tree, run each, record if it succeeds
# report and total failures.
#
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
