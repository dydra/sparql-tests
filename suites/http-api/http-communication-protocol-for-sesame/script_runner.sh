#! /bin/bash


# http api tests
#
# environment :
# STORE_URL : host http url
# STORE_ACCOUNT : account name
# STORE_REPOSITORY : individual repository
# STORE_TOKEN : the authentication token

if [[ "" == "${STORE_URL}" ]]
then
  export STORE_URL="http://localhost"
fi
export STORE_HOST=${STORE_URL:7}
export STORE_ACCOUNT="openrdf-sesame"
export STORE_REPOSITORY="mem-rdf"
export STORE_TOKEN=`cat ~/.dydra/token-${STORE_ACCOUNT}`
export STORE_PREFIX="rdf"
export STORE_DGRAPH="sesame"
export STORE_IGRAPH="http://example.org"
export STORE_IS_LOCAL=false
fgrep 127.0.0.1 /etc/hosts | fgrep -q ${STORE_HOST}
if [[ "$?" == "0" ]]
then
  export STORE_IS_LOCAL=true
fi
STORE_ERRORS=0

cat > /tmp/PUT.nq <<EOF
<http://example.com/default-subject> <http://example.com/default-predicate> "default object" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object" <http://dydra.com/graph-name> .
EOF

# provide an operator to restore the store to a known state
# it presumes, that the statements PUT operator works
initialize_repository () {
    curl -L -f -s -S -X PUT \
     -H "Content-Type: application/n-quads" --data-binary @/tmp/PUT.nq \
     ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} 
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
    (( STORE_ERRORS = $STORE_ERRORS + 1))
    echo $STORE_ERRORS
  fi
  if [[ ! "${script_filename:0:4}" == "GET-" ]]
  then
    initialize_repository
  fi
done

if [[ "${STORE_ERRORS}" == "0" ]]
then
  echo "${STORE_ERRORS} errors"
fi

exit ${STORE_ERRORS}
