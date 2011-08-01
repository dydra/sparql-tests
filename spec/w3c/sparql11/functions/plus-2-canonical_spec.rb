# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# plus-2
# plus operator in combination with str(), i.e.  str(?x) + str(?y), on string and numeric values
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/functions/plus-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#plus-2
#
# This test is approved: 
# 
# 20110206 jaa : canonical blank node indicator
#   bug : result failes to match 

describe "W3C test" do
  context "functions" do
    before :all do
      @data = %q{
@prefix : <http://example/> .
@prefix  xsd:    <http://www.w3.org/2001/XMLSchema#> .

:x1 :p  "a" ; :q 1 .
:x2 :p  _:b ; :q "1".
:x3 :p  :a ; :q "1".
:x4 :p  1 ; :q 2 .
:x5 :p  1.0 ; :q 2 .
:x6 :p  "1" ; :q "2" .
:x7 :p  "1"^^xsd:string ; :q "2" .
:x8 :p  "1"^^xsd:string ; :q 2 .








}
      @query = %q{
PREFIX  : <http://example/>

SELECT  ?x ?y ( str(?x) + str(?y) AS ?sum)
WHERE
    { ?s :p ?x ; :q ?y . 
    }
ORDER BY ?x ?y ?sum

}
    end

    example "plus-2", :status => 'bug', :w3c_status => 'unapproved', :blank_nodes => 'canonical', :arithmetic => 'native' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'functions-plus-2'
      expected = [
          { 
              :x => RDF::Node.new('b'),
              :y => RDF::Literal.new('1' ),
          },
          { 
              :x => RDF::URI('http://example/a'),
              :y => RDF::Literal.new('1' ),
          },
          { 
              :x => RDF::Literal.new('1' ),
              :y => RDF::Literal.new('2' ),
          },
          { 
              :x => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
              :y => RDF::Literal.new('2.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              :x => RDF::Literal.new('1'),
              :y => RDF::Literal.new('2' ),
          },
          { 
              :x => RDF::Literal.new('1'),
              :y => RDF::Literal.new('2.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              :x => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
              :y => RDF::Literal.new('2.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              :x => RDF::Literal.new('a' ),
              :y => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
