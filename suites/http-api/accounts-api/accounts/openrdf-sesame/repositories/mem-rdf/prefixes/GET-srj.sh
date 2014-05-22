#! /bin/bash

# verify presence of standard first and last prefix namespace bindings

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+json" \
     $STORE_URL/accounts/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/prefixes?auth_token=${STORE_TOKEN} \
  | json_reformat -m \
  | fgrep '{"prefix":{"type":"literal","value":"cc"}' \
  | fgrep -q '{"prefix":{"type":"literal","value":"xsd"}'

