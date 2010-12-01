# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Test 'boolean effective value' - optional
# The EBV of an unbound value  or a literal with an unknown datatype is a type error, which eliminates the solution in question
# /Users/ben/repos/datagraph/tests/tests/data-r2/boolean-effective-value/query-bev-5.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-bev-5
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/att-0082/2007-06-12-dawg-minutes.html
#
describe "W3C test " do
  context "boolean-effective-value" do
    before :all do
      @data = %q{
@prefix : <http://example.org/ns#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

# These object values are true by the boolean effective value rule.
:x1 :p    "1"^^xsd:integer .
:x2 :p    "foo" .
:x3 :p    "0.01"^^xsd:double .
:x4 :p    "true"^^xsd:boolean .

# These are false
:y1 :p    "0"^^xsd:integer .
:y2 :p    "0.0"^^xsd:double .
:y3 :p    "" .
:y4 :p    "false"^^xsd:boolean .

# Optionals
:x1 :q    "true"^^xsd:boolean .
:x2 :q    "false"^^xsd:boolean .
:x3 :q    "foo"^^:unknown .

}
      @query = %q{
PREFIX  xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX  : <http://example.org/ns#>
SELECT  ?a
WHERE
    { ?a :p ?v . 
      OPTIONAL
        { ?a :q ?w } . 
      FILTER (?w) .
    }

}
    end

    it "Test 'boolean effective value' - optional" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'boolean-effective-value-dawg-bev-5'
      results = [
          { 
              "a" => RDF::URI('http://example.org/ns#x1'),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
