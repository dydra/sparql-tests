# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# GROUP_CONCAT 1
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/aggregates/agg-groupconcat-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#agg-groupconcat-01
#
# This test is approved: 
# http://www.w3.org/2009/sparql/meeting/2010-09-07#resolution_2
#
describe "W3C test" do
  context "aggregates" do
    before :all do
      @data = %q{
@prefix : <http://www.example.org/> .

:s :p1 "1", "22" .
:s :p2 "aaa", "bb", "c" .

}
      @query = %q{
PREFIX : <http://www.example.org/>
ASK {
	{SELECT (GROUP_CONCAT(?o) AS ?g) WHERE {
		[] :p1 ?o
	}}
	FILTER(?g = "1 22" || ?g = "22 1")
}

}
    end

    example "GROUP_CONCAT 1", :status => 'unverified' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'aggregates-agg-groupconcat-01'
      expected = true

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :ask).should == expected
    end
  end
end
