#! /bin/bash


curl -w "%{http_code}\n" -f -s -S -X POST \
     -H "Content-Type: application/trix" \
     --data-binary @- \
     $STORE_URL/${STORE_ACCOUNT}/repositories/${STORE_REPOSITORY}/statements <<EOF\
   | fgrep -q "${STATUS_UNSUPPORTED_MEDIA}"
<?xml version="1.0" encoding="utf-8"?>
<graph>
  <uri>http://dydra.com/put-graph-name</uri>
  <triple>
   <uri>http://example.com/default-subject</uri>
   <uri>http://example.com/default-predicate</uri>
   <plainLiteral>default object . PUT.nt</plainLiteral>
  </triple>
</graph>
EOF

echo -n " NYI "
