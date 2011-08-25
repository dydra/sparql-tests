# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sq03 - Subquery within graph pattern, graph variable is not bound
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/subquery/sq03.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#subquery03
#
# This test is approved: 
# http://www.w3.org/2009/sparql/meeting/2010-07-13#resolution_4
#
describe "W3C test" do
  context "subquery" do
    before :all do
       # sq01.rdf -> .ttl
       @graph0 = %q{
@base <http://example.com/sq03.rdf> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix in: <http://www.example.org/instance#> .
@prefix ex: <http://www.example.org/schema#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

in:a ex:p in:b .
in:c ex:p <> .
}
      @query = %q{
prefix ex:	<http://www.example.org/schema#>
prefix in:	<http://www.example.org/instance#>

select ?x where {
graph ?g {
  {select ?x where {?x ?p ?g}}
}
}
}
    end

    example "sq03 - Subquery within graph pattern, graph variable is not bound (as ttl)" do
    
      graphs = {}
      graphs[:default] = nil

      graphs[RDF::URI('http://example.com/sq03.rdf')] = { :data => @graph0, :format => :ttl }

      repository = 'subquery-subquery03'
      expected = [
          { 
              :x => RDF::URI('http://www.example.org/instance#c'),
          },
          { 
              :x => RDF::URI('http://www.example.org/instance#a'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
