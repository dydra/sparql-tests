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
export STORE_REPOSITORY_PUBLIC="public"
export STORE_TOKEN=`cat ~/.dydra/token-${STORE_ACCOUNT}`
export STORE_PREFIX="rdf"
export STORE_DGRAPH="sesame"
export STORE_IGRAPH="http://example.org"
export STORE_NAMED_GRAPH="http://dydra.com/graph-name"
export STORE_IS_LOCAL=false
fgrep 127.0.0.1 /etc/hosts | fgrep -q ${STORE_HOST}
if [[ "$?" == "0" ]]
then
  export STORE_IS_LOCAL=true
fi

export PUT_SUCCESS=201
export POST_SUCCESS=201
export DELETE_SUCCESS=204
export STATUS_BAD_REQUEST=400
export STATUS_UNAUTHORIZED=401
export STATUS_NOT_ACCEPTABLE=406
export STATUS_UNSUPPORTED_MEDIA=415
STORE_ERRORS=0


# provide operators to restore aspects of the store to a known state
# they presumes, that the various PUT operators work

function initialize_repository () {
curl -w "%{http_code}\n" -L -f -s -X PUT \
     -H "Accept: application/n-quads" \
     -H "Content-Type: application/n-quads" --data-binary @- \
     ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} <<EOF
<http://example.com/default-subject> <http://example.com/default-predicate> "default object" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object" <${STORE_NAMED_GRAPH}> .
EOF
}

function initialize_repository_public () {
curl -w "%{http_code}\n" -L -f -s -X PUT \
     -H "Content-Type: application/n-quads" --data-binary @- \
     ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY_PUBLIC}?auth_token=${STORE_TOKEN} <<EOF
<http://example.com/default-subject> <http://example.com/default-predicate> "default object" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object" <${STORE_NAMED_GRAPH}> .
EOF
}

function initialize_repository_rdf_graphs () {
curl -w "%{http_code}\n" -L -f -s -X PUT \
     -H "Accept: application/n-quads" \
     -H "Content-Type: application/n-quads" --data-binary @- \
     ${STORE_URL}/${STORE_ACCOUNT}/${STORE_REPOSITORY}?auth_token=${STORE_TOKEN} <<EOF
<http://example.com/default-subject> <http://example.com/default-predicate> "default object" .
<http://example.com/named-subject> <http://example.com/named-predicate> "named object" <${STORE_NAMED_GRAPH}> .
<http://example.com/named-subject> <http://example.com/named-predicate> "rdf-graphs named object" <$STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/rdf-graphs/sesame> .
EOF
}

function initialize_about () {
curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: " \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/about?auth_token=${STORE_TOKEN} <<EOF 
{
    "name": "mem-rdf",
    "homepage": "http://example.org/test",
    "summary": "a summary",
    "description": "a description",
    "license_url": "http://unlicense.org"
 }
EOF
}

function initialize_collaboration () {
curl -w "%{http_code}\n" -f -s -X POST \
     -H "Content-Type: application/json" \
     -H "Accept: " \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/collaborations?auth_token=${STORE_TOKEN} <<EOF
{"collaborator": "jhacker",
 "read": true,
 "write": false
 }
EOF
}

function initialize_prefixes () {
curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: " \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} <<EOF
{"default_repository_prefixes":{"cc":"http://creativecommons.org/ns#","cert":"http://www.w3.org/ns/auth/cert#","dbp":"http://dbpedia.org/property/","dc":"http://purl.org/dc/terms/","dc11":"http://purl.org/dc/elements/1.1/","dcterms":"http://purl.org/dc/terms/","doap":"http://usefulinc.com/ns/doap#","exif":"http://www.w3.org/2003/12/exif/ns#","fn":"http://www.w3.org/2005/xpath-functions#","foaf":"http://xmlns.com/foaf/0.1/","geo":"http://www.w3.org/2003/01/geo/wgs84_pos#","geonames":"http://www.geonames.org/ontology#","gr":"http://purl.org/goodrelations/v1#","http":"http://www.w3.org/2006/http#","log":"http://www.w3.org/2000/10/swap/log#","owl":"http://www.w3.org/2002/07/owl#","rdf":"http://www.w3.org/1999/02/22-rdf-syntax-ns#","rdfs":"http://www.w3.org/2000/01/rdf-schema#","rei":"http://www.w3.org/2004/06/rei#","rsa":"http://www.w3.org/ns/auth/rsa#","rss":"http://purl.org/rss/1.0/","sfn":"http://www.w3.org/ns/sparql#","sioc":"http://rdfs.org/sioc/ns#","skos":"http://www.w3.org/2004/02/skos/core#","swrc":"http://swrc.ontoware.org/ontology#","types":"http://rdfs.org/sioc/types#","wot":"http://xmlns.com/wot/0.1/","xhtml":"http://www.w3.org/1999/xhtml#","xsd":"http://www.w3.org/2001/XMLSchema#"}
}
EOF
}

function initialize_privacy () {
curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/privacy?auth_token=${STORE_TOKEN} <<EOF
{"permissable_ip_addresses":["192.168.1.1"],"privacy_setting":1}
EOF
}


export -f initialize_repository
export -f initialize_repository_public
export -f initialize_repository_rdf_graphs
export -f initialize_about
export -f initialize_collaboration
export -f initialize_prefixes
export -f initialize_privacy


initialize_repository | fgrep -q "${PUT_SUCCESS}"
initialize_repository_public | fgrep -q "${PUT_SUCCESS}"

# iterate over all '.sh' scripts in the current wd tree, run each, record if it succeeds
# report and total failures.
#
# nb. the outer binding scope includes the loop for the "for in do" form,
# but not the "while read do" due to the pipe
#   find ./*/ -name '*.sh*' | while read file; do
# this limits the test complement to the number of arguments the shell permits

SCRIPTS="$1"
if [[ "${SCRIPTS}" != "" ]]
then
  SCRIPTS=`ls ${SCRIPTS}`
else
  SCRIPTS=`find ./*/ -name '*.sh*'`
fi

for script_pathname in $SCRIPTS
do
  echo -n $script_pathname;
  script_filename=`basename $script_pathname`
  script_directory=`dirname $script_pathname`
  ( cd $script_directory;
    bash -e $script_filename;
  )
  if [[ $? == "0" ]]
  then
    echo "   ok"
  else
    echo "   failed";
    (( STORE_ERRORS = $STORE_ERRORS + 1))
  fi
done

if [[ "${STORE_ERRORS}" != "0" ]]
then
  echo "${STORE_ERRORS} errors"
fi

exit ${STORE_ERRORS}
