# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Join operator with OPTs, BGPs, and UNIONs
# Tests nested combination of Join with a BGP / OPT and a BGP / UNION
# /Users/ben/repos/datagraph/tests/tests/data-r2/algebra/join-combo-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#join-combo-1
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0096/21-dawg-minutes.html
#
describe "W3C test" do
  context "algebra" do
    before :all do
      @data = %q{
@prefix   :         <http://example/> .
@prefix   rdf:      <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x1 :p "1"^^xsd:integer .
:x1 :r "4"^^xsd:integer .
:x2 :p "2"^^xsd:integer .
:x2 :r "10"^^xsd:integer .
:x2 :x "1"^^xsd:integer .
:x3 :q "3"^^xsd:integer .
:x3 :q "4"^^xsd:integer .
:x3 :s "1"^^xsd:integer .
:x3 :t :s .
:p a rdf:Property .
:x1 :z :p .

}
      @query = %q{
PREFIX :    <http://example/>

SELECT ?a ?y ?d ?z
{ 
    ?a :p ?c OPTIONAL { ?a :r ?d }. 
    ?a ?p 1 { ?p a ?y } UNION { ?a ?z ?p } 
}
}
    end

    example "Join operator with OPTs, BGPs, and UNIONs" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'algebra-join-combo-1'
      expected = [
          { 
              :a => RDF::URI('http://example/x1'),
              :d => RDF::Literal.new('4' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :y => RDF::URI('http://www.w3.org/1999/02/22-rdf-syntax-ns#Property'),
          },
          { 
              :a => RDF::URI('http://example/x1'),
              :d => RDF::Literal.new('4' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :z => RDF::URI('http://example/z'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
