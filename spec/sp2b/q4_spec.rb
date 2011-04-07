# coding: utf-8
#
require 'spec_helper'

# SP2B Query 4 50k triples
# 
describe "SP2B" do
  context "query 4" do
    before :all do
      @repository = ENV['REPOSITORY'] || 'sp2b-50k'
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + @repository + '.nt'
      
      @query = %q(
PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX bench:   <http://localhost/vocabulary/bench/>
PREFIX dc:      <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX foaf:    <http://xmlns.com/foaf/0.1/>
PREFIX swrc:    <http://swrc.ontoware.org/ontology#>

SELECT DISTINCT ?name1 ?name2 
WHERE {
  ?article1 rdf:type bench:Article .
  ?article2 rdf:type bench:Article .
  ?article1 dc:creator ?author1 .
  ?author1 foaf:name ?name1 .
  ?article2 dc:creator ?author2 .
  ?author2 foaf:name ?name2 .
  ?article1 swrc:journal ?journal .
  ?article2 swrc:journal ?journal
  FILTER (?name1<?name2)
}
)
    end

    example "sp2b-q4-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      expected_length = 104746

      sparql_query(:graphs => graphs, :query => @query,       # use unordered test
                   :repository => @repository, :form => :select).length.should == expected_length
    end
  end
end
