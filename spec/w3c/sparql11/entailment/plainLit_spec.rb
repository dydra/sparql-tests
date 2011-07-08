# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Plain literals with language tag are not the same as the same literal without
# 
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/entailment/lang.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#plainLit
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "entailment" do
    before :all do
      @data = %q{
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . @prefix foaf: <http://xmlns.com/foaf/0.1/> .@prefix : <http://example.org/test#> .@prefix owl: <http://www.w3.org/2002/07/owl#> ._:ont a owl:Ontology . foaf:name a owl:DatatypeProperty . :a foaf:name "name" .:b foaf:name "name"@en .
}
      @query = %q{
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX foaf:  <http://xmlns.com/foaf/0.1/>

SELECT ?x
WHERE { ?x foaf:name "name"@en .
      } 
}
    end

    example "Plain literals with language tag are not the same as the same literal without", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'entailment-plainLit'
      expected = [
          { 
              :x => RDF::URI('http://example.org/test#b'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
