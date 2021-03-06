# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Group-1
# Simple grouping
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/grouping/group01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#group01
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "grouping" do
    before :all do
      @data = %q{
@prefix : <http://example/> .

:s1 :p 1 .
:s1 :q 9 .
:s2 :p 2 . 

}
      @query = %q{
PREFIX : <http://example/>

SELECT ?s
{
  ?s :p ?v .
}
GROUP BY ?s

}
    end

    example "Group-1", :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'grouping-group01'
      expected = [
          { 
              :s => RDF::URI('http://example/s1'),
          },
          { 
              :s => RDF::URI('http://example/s2'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
