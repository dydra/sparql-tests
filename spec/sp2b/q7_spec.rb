# coding: utf-8
#
require 'spec_helper'

# SP2B Query 7 50k triples
# 
describe "SP2B" do
  context "query 7" do
    before :all do
      @repository = ENV['REPOSITORY'] || 'sp2b-50k'
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + @repository + '.nt'
      
      @query = %q(
PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:    <http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf:    <http://xmlns.com/foaf/0.1/>
PREFIX dc:      <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>

SELECT DISTINCT ?title
WHERE {
  ?class rdfs:subClassOf foaf:Document .
  ?doc rdf:type ?class .
  ?doc dc:title ?title .
  ?bag2 ?member2 ?doc .
  ?doc2 dcterms:references ?bag2
  OPTIONAL {
    ?class3 rdfs:subClassOf foaf:Document .
    ?doc3 rdf:type ?class3 .
    ?doc3 dcterms:references ?bag3 .
    ?bag3 ?member3 ?doc
    OPTIONAL {
      ?class4 rdfs:subClassOf foaf:Document .
      ?doc4 rdf:type ?class4 .
      ?doc4 dcterms:references ?bag4 .
      ?bag4 ?member4 ?doc3
    } FILTER (!bound(?doc4))
  } FILTER (!bound(?doc3))
}
)
    end

    example "sp2b-q7-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      expected = [
          {
           :title => RDF::Literal.new('sissies reprobate rethink', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          {
           :title => RDF::Literal.new('doorless chiasma alibiing', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
      ]

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => @repository, :form => :select).should =~ expected
    end
  end
end
