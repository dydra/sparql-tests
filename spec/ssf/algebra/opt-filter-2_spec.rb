# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Optional-filter - 2 filters
# FILTERs inside an OPTIONAL can refer to variables from both the required and optional parts of the construct.
# /Users/ben/repos/datagraph/tests/tests/data-r2/algebra/opt-filter-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#opt-filter-2
#
# This test is approved: 
# http://www.w3.org/2007/06/19-dawg-minutes.html
#
describe "W3C test" do
  context "algebra" do
    before :all do
      @data = %q{
@prefix   :         <http://example/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x1 :p "1"^^xsd:integer .
:x2 :p "2"^^xsd:integer .

:x3 :q "3"^^xsd:integer .
:x3 :q "4"^^xsd:integer .
 

}
      @query = %q{
(select (?x ?v ?y ?w)
        (leftjoin
         (bgp (triple ?x <http://example/p> ?v))
         (bgp (triple ?y <http://example/q> ?w))
         (exprlist (= ?v 2) (= ?w 3))))

}
    end

    example "Optional-filter - 2 filters" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'algebra-opt-filter-2'
      expected = [
          { 
              :v => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :w => RDF::Literal.new('3' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x => RDF::URI('http://example/x2'),
              :y => RDF::URI('http://example/x3'),
          },
          { 
              :v => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x => RDF::URI('http://example/x1'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
