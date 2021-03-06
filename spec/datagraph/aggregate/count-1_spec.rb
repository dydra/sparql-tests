# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Limit 1
# 
# sparql-tests:spec/w3c/data-sparql11/aggregate/syntax-aggregate-01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2009/sparql/docs/tests/data-sparql11/syntax-query/
#
# This test is a draft: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2011JanMar/0069.html
#

describe "W3C test" do
  context "aggregate-count-1" do
    before :all do
      @data = %q{
@prefix :    <http://example.org/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

<xsd:float> :number  "10.0"^^xsd:float .
<xsd:double> :number  "10.0"^^xsd:double .
<xsd:integer> :number  "40"^^xsd:integer .

<xsd:string> :string "10" .

}
      @query = %q{
PREFIX :    <http://example.org/ns#>
PREFIX xsd: <http://example.org/ns#>

SELECT (COUNT (?v) AS ?count)
WHERE { ?type ?class ?v }

}
    end

    example "Count 1" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'count-1'
      expected = [
          { 
              :count => RDF::Literal.new('4' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
