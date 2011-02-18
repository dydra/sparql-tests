# coding: utf-8
#
require 'spec_helper'

# SP2B Query 6 50k triples
# 
describe "SP2B" do
  context "query 6" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/sp2b-50k.nt'
      
      @query = %q(
PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:    <http://www.w3.org/2000/01/rdf-schema#>
PREFIX foaf:    <http://xmlns.com/foaf/0.1/>
PREFIX dc:      <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>

SELECT ?yr ?name ?document
WHERE {
  ?class rdfs:subClassOf foaf:Document .
  ?document rdf:type ?class .
  ?document dcterms:issued ?yr .
  ?document dc:creator ?author .
  ?author foaf:name ?name
  OPTIONAL {
    ?class2 rdfs:subClassOf foaf:Document .
    ?document2 rdf:type ?class2 .
    ?document2 dcterms:issued ?yr2 .
    ?document2 dc:creator ?author2 
    FILTER (?author=?author2 && ?yr2<?yr)
  } FILTER (!bound(?author2))
}
)
    end

    example "sp2b-q6-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      repository = 'sp2b-50k'
      expected_length = 0

      sparql_query(:graphs => graphs, :query => @query,       # test length only
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
