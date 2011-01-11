# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# graph-07
# Data: default and named / Query: all data by UNION
# /Users/ben/repos/datagraph/tests/tests/data-r2/graph/graph-07.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-graph-07
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0047/31-dawg-minutes
#
# 20101220 jaa : bug indicator : graphs are NYI

describe "W3C test" do
  context "graph" do
    before :all do
      @data = %q{
@prefix : <http://example/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x :p "1"^^xsd:integer .
:a :p "9"^^xsd:integer .

}
       # data-g2.ttl
       @graph0 = %q{
@prefix : <http://example/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x :q "2"^^xsd:integer .

}
      @query = %q{
PREFIX : <http://example/> 

SELECT * 
{ 
   { ?s ?p ?o }
  UNION
   { GRAPH ?g { ?s ?p ?o } }
}

}
    end

    example "graph-07", :status => 'bug' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}

      graphs[RDF::URI('data-g2.ttl')] = { :data => @graph0, :format => :ttl }

      repository = 'graph-dawg-graph-07'
      expected = [
          { 
              :g => RDF::URI('/Users/ben/repos/datagraph/tests/tests/data-r2/graph/data-g2.ttl'),
              :o => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :p => RDF::URI('http://example/q'),
              :s => RDF::URI('http://example/x'),
          },
          { 
              :o => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :p => RDF::URI('http://example/p'),
              :s => RDF::URI('http://example/x'),
          },
          { 
              :o => RDF::Literal.new('9' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :p => RDF::URI('http://example/p'),
              :s => RDF::URI('http://example/a'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
