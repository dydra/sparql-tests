# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Basic - Quotes 3
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/basic/quotes-3.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#quotes-3
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0060/2007-08-07-dawg-minutes.html
#
describe "W3C test" do
  context "basic" do
    before :all do
      @data = %q{
@prefix : <http://example.org/ns#> .

# This file uses UNIX line end conventions.

:x1 :p1 "x" .
:x2 :p2 """x
y""" .

:x3 :p3 """x
y"""^^:someType .



}
      @query = %q{
        (prefix ((: <http://example.org/ns#>))
          (project (?x)
            (bgp (triple ?x ?p "x\ny"))))}
    end

    example "Basic - Quotes 3" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'basic-quotes-3'
      expected = [
          { 
              :x => RDF::URI('http://example.org/ns#x2'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
