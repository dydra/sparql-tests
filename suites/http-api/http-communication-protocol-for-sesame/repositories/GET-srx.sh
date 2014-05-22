#! /bin/sh

curl -f -s -S -X GET\
     -H "Accept: application/sparql-results+xml" \
     $STORE_URL/${STORE_ACCOUNT}/repositories?auth_token=${STORE_TOKEN} \
   | xmllint --c14n11 - | tr -s '\t\n\r\f' ' ' | sed 's/ +/ /g' \
   | fgrep '<literal>SYSTEM</literal>' \
   | fgrep '<literal>mem-rdf</literal>' \
   | fgrep '<literal>public</literal>' \
   | fgrep '<literal>public-authenticated</literal>' \
   | tr -s ':' '\n' | fgrep -c '<binding name="id">' | fgrep -q '4'


