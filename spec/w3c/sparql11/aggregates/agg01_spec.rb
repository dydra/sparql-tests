# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# COUNT 1
# Simple count
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/aggregates/agg01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#agg01
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "aggregates" do
    before :all do
      @data = %q{
@prefix : <http://www.example.org/> .

:s :p1 :o1, :o2, :o3.
:s :p2 :o1, :o2.

}
      @query = %q{
PREFIX : <http://www.example.org>

SELECT (COUNT(?O) AS ?C)
WHERE { ?S ?P ?O }

}
    end

    example "COUNT 1", :unverified => true, :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'aggregates-agg01'
      expected = [
          { 
              :C => RDF::Literal.new('5' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
