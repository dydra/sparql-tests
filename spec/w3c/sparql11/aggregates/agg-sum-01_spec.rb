# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# SUM
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/aggregates/agg-sum-01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#agg-sum-01
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "aggregates" do
    before :all do
      @data = %q{
@prefix : <http://www.example.org/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

:ints :int 1, 2, 3 .
:decimals :dec 1.0, 2.2, 3.5 .
:doubles :double 1.0E2, 2.0E3, 3.0E4 .
:mixed1 :int 1 ; :dec 2.2 .
:mixed2 :double 2E-1 ; :dec 2.2 .

}
      @query = %q{
PREFIX : <http://www.example.org/>
SELECT (SUM(?o) AS ?sum)
WHERE {
	?s :dec ?o
}

}
    end

    example "SUM", :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'aggregates-agg-sum-01'
      expected = [
          { 
              :sum => RDF::Literal.new('11.1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
