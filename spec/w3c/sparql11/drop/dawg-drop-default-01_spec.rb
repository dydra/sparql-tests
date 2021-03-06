# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# DROP DEFAULT
# This is a DROP of the default graph
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/drop/drop-default-01.ru
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-drop-default-01
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "drop" do
    before :all do
      @data = %q{
@base   <http://example.org/drop-default.ttl> .
@prefix : <http://example.org/> .

<> :name "Default Graph" .

}
       # http://example.org/g1
       @graph0 = %q{
@prefix : <http://example.org/> .

:g1 :name "G1" ;
	:description "Graph 1" ;
	.

}
       # http://example.org/g2
       @graph1 = %q{
@prefix : <http://example.org/> .

:g2 :name "G2" ;
	.

}
      @query = %q{
PREFIX     : <http://example.org/> 

DROP DEFAULT


}
    end

    example "DROP DEFAULT", :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}

      graphs[RDF::URI('http://example.org/g1')] = { :data => @graph0, :format => :ttl }
      graphs[RDF::URI('http://example.org/g2')] = { :data => @graph1, :format => :ttl }

      repository = 'drop-dawg-drop-default-01'
      expected = [
          {
            :s => RDF::URI('http://example.org/g1'),
            :p => RDF::URI('http://example.org/name'),
            :o => RDF::Literal.new('G1' ),
            :g => RDF::URI('http://example.org/g1')
          },
          {
            :s => RDF::URI('http://example.org/g1'),
            :p => RDF::URI('http://example.org/description'),
            :o => RDF::Literal.new('Graph 1' ),
            :g => RDF::URI('http://example.org/g1')
          },
          {
            :s => RDF::URI('http://example.org/g2'),
            :p => RDF::URI('http://example.org/name'),
            :o => RDF::Literal.new('G2' ),
            :g => RDF::URI('http://example.org/g2')
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :update).should =~ expected
    end
  end
end
