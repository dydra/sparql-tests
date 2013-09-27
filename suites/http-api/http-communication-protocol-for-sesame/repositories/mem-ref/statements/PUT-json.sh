#! /bin/bash


curl -w "%{http_code}\n" -f -s -S -X PUT \
     -H "Content-Type: application/rdf+json" \
     -data-binary @-
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements <<EOF \
 | fgrep -q "${STATUS_UNSUPPORTED_MEDIA}"
{ "http://example.com/default-subject" : {
  "http://example.com/default-predicate" : [ { "value" : "default object . sesame rdf-graphs PUT.rj",
                                               "type" : "literal" } ]
  }
}
EOF

echo " NYI"
