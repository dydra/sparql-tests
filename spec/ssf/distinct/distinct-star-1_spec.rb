# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# SELECT DISTINCT *
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/distinct/distinct-star-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#distinct-star-1
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0060/2007-08-07-dawg-minutes.html
#
describe "W3C test" do
  context "distinct" do
    before :all do
      @data = %q{
@prefix :         <http://example/> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .

:x1 :p "abc" .
:x1 :q "abc" .
:x2 :p "abc" .



}
      @query = %q{
(select (?s ?o)
        (distinct
         (union
          (bgp (triple ?s <http://example/p> ?o))
          (bgp (triple ?s <http://example/q> ?o)))))

}
    end

    example "SELECT DISTINCT *" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'distinct-distinct-star-1'
      expected = [
          { 
              :o => RDF::Literal.new('abc' ),
              :s => RDF::URI('http://example/x1'),
          },
          { 
              :o => RDF::Literal.new('abc' ),
              :s => RDF::URI('http://example/x2'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
