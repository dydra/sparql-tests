# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# lang-1 : Literals with a lang tag of some kind
# updated from original test case: eliminated ordering from test
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-builtin/q-lang-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-lang-1
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/0006
#
describe "W3C test " do
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
    (filter (!= (lang ?v) "@NotALangTag@")
      (bgp (triple ?x <http://example/p> ?v)))))

}
    end

    it "lang-1 : Literals with a lang tag of some kind" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'expr-builtin-dawg-lang-1'
      results = [
          { 
              "x" => RDF::URI('http://example/x1'),
          },
          { 
              "x" => RDF::URI('http://example/x2'),
          },
          { 
              "x" => RDF::URI('http://example/x3'),
          },
          { 
              "x" => RDF::URI('http://example/x4'),
          },
          { 
              "x" => RDF::URI('http://example/x5'),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
