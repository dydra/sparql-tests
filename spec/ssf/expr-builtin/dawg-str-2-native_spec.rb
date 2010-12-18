# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# str-2
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-builtin/q-str-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-str-2
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/0006
#
# 20101218 jaa arithmetic taging

describe "W3C test" do
  context "expr-builtin" do
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

:xt1 :p  "zzz"^^:myType .

:xp1 :p  "zzz" .
:xp2 :p  "1" .
:xp2 :p  "" .

:xu :p  :z .

:xb :p  _:a .

}
      @query = %q{
(select (?x ?v)
  (project (?x ?v)
    (filter (= (str ?v) "01")
      (bgp (triple ?x <http://example.org/things#p> ?v)))))

}
    end

    example "str-2", :arithmetic => 'native' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'expr-builtin-dawg-str-2'
      expected = [
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
