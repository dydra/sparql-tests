# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# SUM with GROUP BY
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/aggregates/agg-sum-02.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#agg-sum-02
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "aggregates" do
    before :all do
      @data = %q{
@prefix : <http://www.example.org/> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

:ints :int 1, 2, 3 .
:decimals :dec 1.0, 2.2, 3.5 .
:doubles :double 1.0E2, 2.0E3, 3.0E4 .
:mixed1 :int 1 ; :dec 2.2 .
:mixed2 :double 2E-1 ; :dec 2.2 .

}
      @query = %q{
PREFIX : <http://www.example.org/>
SELECT ?s (SUM(?o) AS ?sum)
WHERE {
	?s ?p ?o
}
GROUP BY ?s

}
    end

    example "SUM with GROUP BY", :unverified => true, :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'aggregates-agg-sum-02'
      expected = [
          { 
              :s => RDF::URI('http://www.example.org/ints'),
              :sum => RDF::Literal.new('6' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              :s => RDF::URI('http://www.example.org/decimals'),
              :sum => RDF::Literal.new('6.7' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              :s => RDF::URI('http://www.example.org/doubles'),
              :sum => RDF::Literal.new('3.21E4' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
          },
          { 
              :s => RDF::URI('http://www.example.org/mixed1'),
              :sum => RDF::Literal.new('3.2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              :s => RDF::URI('http://www.example.org/mixed2'),
              :sum => RDF::Literal.new('2.4E0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
