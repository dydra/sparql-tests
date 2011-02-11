# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Expression raise an error
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/project-expression/projexp02.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#projexp02
#
# This test is approved: 
# http://www.w3.org/2009/sparql/meeting/2010-09-07#resolution_3
#
describe "W3C test" do
  context "project-expression" do
    before :all do
      @data = %q{
@prefix rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:	<http://www.w3.org/2000/01/rdf-schema#> .
@prefix ex:	<http://www.example.org/schema#>.
@prefix in:	<http://www.example.org/instance#>.

in:a ex:p 1 .
in:a ex:q 1 .
in:a ex:q "foobar" .



}
      @query = %q{
prefix ex:	<http://www.example.org/schema#>
prefix in:	<http://www.example.org/instance#>

select ?x ?y ?z ((?y + ?z) as ?sum) where {
  ?x ex:p ?y .
  ?x ex:q ?z
}
}
    end

    example "Expression raise an error" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'project-expression-projexp02'
      expected = [
          { 
              :sum => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x => RDF::URI('http://www.example.org/instance#a'),
              :y => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :z => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              :x => RDF::URI('http://www.example.org/instance#a'),
              :y => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :z => RDF::Literal.new('foobar' ),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
