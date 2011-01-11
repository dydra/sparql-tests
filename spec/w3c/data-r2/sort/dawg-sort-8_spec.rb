# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sort-8
# Sort on several mixed values (bnode, uri, literal)
# /Users/ben/repos/datagraph/tests/tests/data-r2/sort/query-sort-4.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-sort-8
#
# This test is approved: 
# http://www.w3.org/2007/06/26-dawg-minutes
#
# 20101226 jaa : blank node indicator w/ rephrased data

describe "W3C test" do
  context "sort" do
    before :all do
      @data = %q{
@prefix rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .
@prefix ex:        <http://example.org/things#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

_:a foaf:name "Eve" ;
    ex:empId "9"^^xsd:integer .

_:f foaf:name "John" ;
    ex:empId [ ex:number "29"^^xsd:integer ] .

_:g foaf:name "Dirk" ;
    ex:empId <http://example.org/dirk01> .

}
      @query = %q{
PREFIX foaf:       <http://xmlns.com/foaf/0.1/>
PREFIX ex:        <http://example.org/things#> 

SELECT ?name ?emp
WHERE { ?x foaf:name ?name ;
           ex:empId ?emp
      }
ORDER BY ASC(?emp)

}
    end

    example "sort-8", :blank_nodes => 'unique' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'sort-dawg-sort-8'
      expected = [
          { 
              :emp => RDF::Node.new('node0'),
              :name => RDF::Literal.new('John' ),
          },
          { 
              :emp => RDF::URI('http://example.org/dirk01'),
              :name => RDF::Literal.new('Dirk' ),
          },
          { 
              :emp => RDF::Literal.new('9' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :name => RDF::Literal.new('Eve' ),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # ordered sort comparison in rspec is ==
                   :repository => repository, :form => :select).should == expected
    end
  end
end
