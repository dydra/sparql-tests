# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# dawg-construct-reification-1
# Reification of the default graph
# /Users/ben/repos/datagraph/tests/tests/data-r2/construct/query-reif-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#construct-3
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0047/31-dawg-minutes
#
# 20101219 jaa : bug indicator : construct not yet supported by the front-end
# 20110215 ben : remove indicator, test passing

describe "W3C test" do
  context "construct" do
    before :all do
      @data = %q{
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .
@prefix rdf:        <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:	    <http://www.w3.org/2000/01/rdf-schema#> .

_:alice
    rdf:type        foaf:Person ;
    foaf:name       "Alice" ;
    foaf:mbox       <mailto:alice@work> ;
    foaf:knows      _:bob ;
    .

_:bob
    rdf:type        foaf:Person ;
    foaf:name       "Bob" ; 
    foaf:knows      _:alice ;
    foaf:mbox       <mailto:bob@home> ;
    .

}
      @query = %q{
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
PREFIX  foaf:       <http://xmlns.com/foaf/0.1/>

CONSTRUCT { [ rdf:subject ?s ;
              rdf:predicate ?p ;
              rdf:object ?o ] . }
WHERE {
  ?s ?p ?o .
}

}

      @results = %q{
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .
@prefix rdf:        <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

[] rdf:subject _:gff ;
  rdf:predicate rdf:type ;
  rdf:object foaf:Person .

[] rdf:subject _:gff ;
  rdf:predicate foaf:name ;
  rdf:object "Alice" .

[] rdf:subject _:gff ;
  rdf:predicate foaf:mbox ;
  rdf:object <mailto:alice@work> .

[] rdf:subject _:gff ;
  rdf:predicate foaf:knows ;
  rdf:object _:g2a .

[] rdf:subject _:g2a ;
  rdf:predicate rdf:type ;
  rdf:object foaf:Person .

[] rdf:subject _:g2a ;
  rdf:predicate foaf:name ;
  rdf:object "Bob" .

[] rdf:subject _:g2a ;
  rdf:predicate foaf:knows ;
  rdf:object _:gff .

[] rdf:subject _:g2a ;
  rdf:predicate foaf:mbox ;
  rdf:object <mailto:bob@home> .
}
    end

    example "dawg-construct-reification-1" do

      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}
      expected = RDF::Graph.new

      RDF::Reader.for(:turtle).new(@results) do |reader|
        reader.each_statement do |statement|
          expected << statement
        end
      end
      repository = 'construct-construct-3'

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :construct).should be_isomorphic_with expected

    end
  end
end
