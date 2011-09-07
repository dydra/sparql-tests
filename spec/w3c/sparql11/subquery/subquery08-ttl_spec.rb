# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sq08 - Subquery with aggregate
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/subquery/sq08.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#subquery08
#
# This test is approved: 
# http://www.w3.org/2009/sparql/meeting/2010-07-20#resolution_2
#
describe "W3C test" do
  context "subquery" do
    before :all do
      @data = %q{
@base <http://example.com/sq08.rdf> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix in: <http://www.example.org/instance#> .
@prefix ex: <http://www.example.org/schema#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .

in:a
    ex:p 1, 2 .

in:b
    ex:p 3 .
}
      @query = %q{
prefix ex:	<http://www.example.org/schema#>
prefix in:	<http://www.example.org/instance#>

select ?x ?max where {
{select (max(?y) as ?max) where {?x ex:p ?y} } 
?x ex:p ?max
}

}
    end

    example "sq08 - Subquery with aggregate" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'subquery-subquery08'
      expected = [
          { 
              :max => RDF::Literal.new('3' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x => RDF::URI('http://www.example.org/instance#b'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end