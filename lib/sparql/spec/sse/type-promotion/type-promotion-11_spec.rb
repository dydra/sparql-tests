# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# tP-int-short
# Positive test: product of type promotion within the xsd:decimal type tree.
# /Users/ben/repos/datagraph/tests/tests/data-r2/type-promotion/tP-int-short.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#type-promotion-11
#
# This test is approved: 
# http://www.w3.org/2007/07/17-dawg-minutes
#
describe "W3C test" do
  context "type-promotion" do
    before :all do
      @data = %q{
# $Id: tP.ttl,v 1.1 2007/06/29 14:24:48 aseaborne Exp $

@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix t: <http://www.w3.org/2001/sw/DataAccess/tests/data/TypePromotion/tP-0#> .

t:decimal1		rdf:value	"1"^^xsd:decimal .
t:float1		rdf:value	"1"^^xsd:float .
t:double1		rdf:value	"1"^^xsd:double .
t:booleanT		rdf:value	"true"^^xsd:boolean .
t:dateTime1		rdf:value	"2005-01-14T12:34:56"^^xsd:dateTime .

# types derived from xsd:decimal: 

 t:integer1		rdf:value	"1"^^xsd:integer .
  t:nonPositiveIntegerN1	rdf:value	"-1"^^xsd:nonPositiveInteger .
   t:negativeIntegerN1	rdf:value	"-1"^^xsd:negativeInteger .
  t:long1		rdf:value	"1"^^xsd:long .
   t:int1		rdf:value	"1"^^xsd:int .
    t:short1		rdf:value	"1"^^xsd:short .
     t:byte1		rdf:value	"1"^^xsd:byte .
  t:nonNegativeInteger1	rdf:value	"1"^^xsd:nonNegativeInteger .
   t:unsignedLong1	rdf:value	"1"^^xsd:unsignedLong .
    t:unsignedInt1	rdf:value	"1"^^xsd:unsignedInt .
     t:unsignedShort1	rdf:value	"1"^^xsd:unsignedShort .
      t:unsignedByte1	rdf:value	"1"^^xsd:unsignedByte .
   t:positiveInteger1	rdf:value	"1"^^xsd:positiveInteger .


}
      @query = %q{
        (prefix ((xsd: <http://www.w3.org/2001/XMLSchema#>)
                 (t: <http://www.w3.org/2001/sw/DataAccess/tests/data/TypePromotion/tP-0#>)
                 (rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>))
          (ask
            (filter (= (datatype (+ ?l ?r)) xsd:integer)
              (bgp
                (triple t:int1 rdf:value ?l)
                (triple t:short1 rdf:value ?r)
              ))))
}
    end

    example "tP-int-short" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'type-promotion-type-promotion-11'
      expected = true

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :ask).should == expected
    end
  end
end
