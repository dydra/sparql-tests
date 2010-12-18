# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# lang-3 : Graph matching with lang tag being a different case
# updated from original test case: eliminated ordering from test
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-builtin/q-lang-3.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-lang-3
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/0006
#
# 20101218 jaa marked as bug : store response is empty

describe "W3C test" do
  context "expr-builtin" do
    before :all do
      @data = %q{
@prefix : <http://example/> .
@prefix  xsd:    <http://www.w3.org/2001/XMLSchema#> .

:x1 :p  "string" .
:x2 :p  "string"^^xsd:string .
:x3 :p  "string"@en .
:x4 :p  "lex"^^:unknownType .
:x5 :p  "1234"^^xsd:integer .
:x6 :p  <http://example/iri> .
:x7 :p  _:bNode .





}
      @query = %q{
(select (?x)
  (project (?x)
    (bgp (triple ?x <http://example/p> "string"@EN))))

}
    end

    example "lang-3 : Graph matching with lang tag being a different case", :status => 'bug' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'expr-builtin-dawg-lang-3'
      expected = [
          { 
              :x => RDF::URI('http://example/x3'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
