# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Nodes: No distinct
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/distinct/no-distinct-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#no-distinct-3
#
# This test is approved: 
# http://www.w3.org/2007/07/17-dawg-minutes
#
# 20101219 jaa : blank_nodes indicator

describe "W3C test" do
  context "distinct" do
    before :all do
      @data = %q{
@prefix :         <http://example/> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .

:x1 :p1 :z1 .
:x1 :p1 _:a .

:x1 :p2 :z1 .
:x1 :p2 _:a .


}
      @query = %q{
(select (?v)
        (project (?v)
                 (bgp (triple ?x ?p ?v))))

}
    end

    example "Nodes: No distinct", :blank_nodes => 'unique' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'distinct-no-distinct-3'
      expected = [
          { 
              :v => RDF::Node.new('b0'),
          },
          { 
              :v => RDF::Node.new('b0'),
          },
          { 
              :v => RDF::URI('http://example/z1'),
          },
          { 
              :v => RDF::URI('http://example/z1'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
