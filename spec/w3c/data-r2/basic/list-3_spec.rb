# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Basic - List 3
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/basic/list-3.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#list-3
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
PREFIX : <http://example.org/ns#>

SELECT ?p ?v
{ :x ?p (?v) . }


}
    end

    example "Basic - List 3" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'basic-list-3'
      expected = [
          { 
              :p => RDF::URI('http://example.org/ns#list1'),
              :v => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
