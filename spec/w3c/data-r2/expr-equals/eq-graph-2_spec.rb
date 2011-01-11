# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Equality 1-2 -- graph
# Graph pattern matching matches exact terms, not values
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-equals/query-eq-graph-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#eq-graph-2
#
# This test is approved: 
# http://www.w3.org/2007/06/19-dawg-minutes.html
#
# 20101220 jaa arithmetic marker;

describe "W3C test" do
  context "expr-equals" do
    before :all do
      @data = %q{
@prefix    :        <http://example.org/things#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:xi1 :p  "1"^^xsd:integer .
:xi2 :p  "1"^^xsd:integer .
:xi3 :p  "01"^^xsd:integer .

:xd1 :p  "1.0e0"^^xsd:double .
:xd2 :p  "1.0"^^xsd:double .
:xd3 :p  "1"^^xsd:double .

## :xdec1 :p  "1.0"^^xsd:decimal .
## :xdec2 :p  "1"^^xsd:decimal .
## :xdec3 :p  "01"^^xsd:decimal .

:xt1 :p  "zzz"^^:myType .

:xp1 :p  "zzz" .
:xp2 :p  "1" .

:xu :p  :z .

#:xb :p  _:a .

}
      @query = %q{
PREFIX  xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX  : <http://example.org/things#>
SELECT  ?x
WHERE
    { ?x :p 1.0e0 .
    }

}
    end

    example "Equality 1-2 -- graph", :arithmetic => 'boxed' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'expr-equals-eq-graph-2'
      expected = [
          { 
              :x => RDF::URI('http://example.org/things#xd1'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
