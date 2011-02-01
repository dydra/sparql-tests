# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# RDFS inference test subClassOf
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/entailment/rdfs05.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#rdfs05
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "entailment" do
    before :all do
      @data = %q{
@prefix :  <http://example.org/x/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:  <http://www.w3.org/2000/01/rdf-schema#> .

 :x :p :y .
 :x rdf:type :c .
 :c rdfs:subClassOf :d .

}
      @query = %q{
PREFIX     :  <http://example.org/x/>
PREFIX  rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:  <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?x ?c
WHERE { ?x rdf:type ?c . ?c rdfs:subClassOf :d }

}
    end

    example "RDFS inference test subClassOf", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'entailment-rdfs05'
      expected = [
          { 
              :c => RDF::URI('http://example.org/x/c'),
              :x => RDF::URI('http://example.org/x/x'),
          },
          { 
              :c => RDF::URI('http://example.org/x/d'),
              :x => RDF::URI('http://example.org/x/x'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end