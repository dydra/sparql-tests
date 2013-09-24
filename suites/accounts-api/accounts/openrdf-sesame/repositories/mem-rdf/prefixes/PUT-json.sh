#! /bin/bash

# cycle the prefixes to test success
# environment :
# STORE_ACCOUNT : account name
# STORE_URL : host http url 
# STORE_REPOSITORY : individual repository

curl -f -s -X PUT \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} <<EOF \
 | json_reformat -m | fgrep '"cc-not":' | fgrep -q '"xsd-not":'
{"default_repository_prefixes":{"cc-not":"http://creativecommons.org/ns#","xsd-not":"http://www.w3.org/2001/XMLSchema#"}}
EOF

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep '"cc-not":' | fgrep -q '"xsd-not":'
rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -w "%{http_code}\n" -f -s -X PUT \
     -H "Content-Type: application/json" \
     --data-binary @- \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} <<EOF \
 | fgrep -q "204"
{"default_repository_prefixes":{
    "cc": "http:\/\/creativecommons.org\/ns#",
    "cert": "http:\/\/www.w3.org\/ns\/auth\/cert#",
    "dbp": "http:\/\/dbpedia.org\/property\/",
    "dc": "http:\/\/purl.org\/dc\/terms\/",
    "dc11": "http:\/\/purl.org\/dc\/elements\/1.1\/",
    "dcterms": "http:\/\/purl.org\/dc\/terms\/",
    "doap": "http:\/\/usefulinc.com\/ns\/doap#",
    "exif": "http:\/\/www.w3.org\/2003\/12\/exif\/ns#",
    "fn": "http:\/\/www.w3.org\/2005\/xpath-functions#",
    "foaf": "http:\/\/xmlns.com\/foaf\/0.1\/",
    "geo": "http:\/\/www.w3.org\/2003\/01\/geo\/wgs84_pos#",
    "geonames": "http:\/\/www.geonames.org\/ontology#",
    "gr": "http:\/\/purl.org\/goodrelations\/v1#",
    "http": "http:\/\/www.w3.org\/2006\/http#",
    "log": "http:\/\/www.w3.org\/2000\/10\/swap\/log#",
    "owl": "http:\/\/www.w3.org\/2002\/07\/owl#",
    "rdf": "http:\/\/www.w3.org\/1999\/02\/22-rdf-syntax-ns#",
    "rdfs": "http:\/\/www.w3.org\/2000\/01\/rdf-schema#",
    "rei": "http:\/\/www.w3.org\/2004\/06\/rei#",
    "rsa": "http:\/\/www.w3.org\/ns\/auth\/rsa#",
    "rss": "http:\/\/purl.org\/rss\/1.0\/",
    "sfn": "http:\/\/www.w3.org\/ns\/sparql#",
    "sioc": "http:\/\/rdfs.org\/sioc\/ns#",
    "skos": "http:\/\/www.w3.org\/2004\/02\/skos\/core#",
    "swrc": "http:\/\/swrc.ontoware.org\/ontology#",
    "types": "http:\/\/rdfs.org\/sioc\/types#",
    "wot": "http:\/\/xmlns.com\/wot\/0.1\/",
    "xhtml": "http:\/\/www.w3.org\/1999\/xhtml#",
    "xsd": "http:\/\/www.w3.org\/2001\/XMLSchema#"
}}
EOF

rc=$?

if [[ "0" != "$rc" ]]
then
  exit  $rc 
fi

curl -f -s -S -X GET\
     -H "Accept: application/json" \
     ${STORE_URL}/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} \
 | json_reformat -m | fgrep '"cc":' | fgrep -q '"xsd":'
