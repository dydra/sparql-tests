# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# COUNT 5
# Count(*) with grouping
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/aggregates/agg05.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#agg05
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

SELECT ?P (COUNT(*) AS ?C)
WHERE { ?S ?P ?O }
GROUP BY ?P

}
    end

    example "COUNT 5", :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'aggregates-agg05'
      expected = [
          { 
              :C => RDF::Literal.new('3' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :P => RDF::URI('http://www.example.org/p1'),
          },
          { 
              :C => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :P => RDF::URI('http://www.example.org/p2'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
