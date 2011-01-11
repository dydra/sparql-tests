# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sort-1
# Alphabetic sort (ascending) on untyped literals
# /Users/ben/repos/datagraph/tests/tests/data-r2/sort/query-sort-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-sort-1
#
# This test is approved: 
# http://www.w3.org/2007/06/26-dawg-minutes
#
describe "W3C test" do
  context "sort" do
    before :all do
      @data = %q{
@prefix rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .

_:a foaf:name "Eve".
_:b foaf:name "Alice" .
_:c foaf:name "Fred" .
_:e foaf:name "Bob" .

}
      @query = %q{
PREFIX foaf:       <http://xmlns.com/foaf/0.1/>
SELECT ?name
WHERE { ?x foaf:name ?name }
ORDER BY ?name

}
    end

    example "sort-1" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'sort-dawg-sort-1'
      expected = [
          { 
              :name => RDF::Literal.new('Alice' ),
          },
          { 
              :name => RDF::Literal.new('Bob' ),
          },
          { 
              :name => RDF::Literal.new('Eve' ),
          },
          { 
              :name => RDF::Literal.new('Fred' ),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # ordered sort comparison in rspec is ==
                   :repository => repository, :form => :select).should == expected
    end
  end
end
