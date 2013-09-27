#! /bin/bash


curl -w "%{http_code}\n" -f -s -S -X POST \
     -H "Content-Type: application/rdf+xml" \
     --data-binary @- \
     $DYDRA_URL/${DYDRA_ACCOUNT}/repositories/${DYDRA_REPOSITORY}/statements?auth_token=${STORE_TOKEN} <<EOF
<?xml version="1.0" encoding="utf-8"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="http://example.com/default-subject">
    <ns0:default-predicate xmlns:ns0="http://example.com/">default object . PUT.nt</ns0:default-predicate>
  </rdf:Description>
</rdf:RDF>
EOF


initialize_repository | fgrep -q "${POST_SUCCESS}"
