# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Basic - List 1
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/basic/list-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#list-1
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0060/2007-08-07-dawg-minutes.html
#
describe "W3C test" do
  context "basic" do
    before :all do
      @data = %q{
@prefix : <http://example.org/ns#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .


:x :list0 () .
:x :list1 ("1"^^xsd:integer) .
:x :list2 ("11"^^xsd:integer "22"^^xsd:integer) .
:x :list3 ("111"^^xsd:integer "222"^^xsd:integer "333"^^xsd:integer) .

}
      @query = %q{
        (prefix ((: <http://example.org/ns#>))
          (project (?p)
            (bgp (triple :x ?p <http://www.w3.org/1999/02/22-rdf-syntax-ns#nil>))))}
    end

    example "Basic - List 1" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'basic-list-1'
      expected = [
          { 
              :p => RDF::URI('http://example.org/ns#list0'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
