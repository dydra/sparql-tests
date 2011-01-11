# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# SELECT REDUCED *
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/reduced/reduced-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#reduced-1
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007OctDec/att-0069/13-dawg-minutes.html
#
# 20101220 jaa : reduced indicator

describe "W3C test" do
  context "reduced" do
    before :all do
      @data = %q{
@prefix :         <http://example/> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .

:x1 :p "abc" .
:x1 :q "abc" .
:x2 :p "abc" .



}
      @query = %q{
PREFIX :         <http://example/> 
PREFIX xsd:      <http://www.w3.org/2001/XMLSchema#> 
SELECT REDUCED * 
WHERE { 
  { ?s :p ?o } UNION { ?s :q ?o }
}


}
    end

    example "SELECT REDUCED *", :reduced => 'all' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'reduced-reduced-1'
      expected = [
          { 
              :o => RDF::Literal.new('abc' ),
              :s => RDF::URI('http://example/x1'),
          },
          { 
              :o => RDF::Literal.new('abc' ),
              :s => RDF::URI('http://example/x1'),
          },
          { 
              :o => RDF::Literal.new('abc' ),
              :s => RDF::URI('http://example/x2'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
