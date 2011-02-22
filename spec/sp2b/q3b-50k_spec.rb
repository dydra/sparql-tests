# coding: utf-8
#
require 'spec_helper'

# SP2B Query 3b 50k triples
# 
describe "SP2B" do
  context "query 3b" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/sp2b-50k.nt'
      
      @query = %q(
PREFIX rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX bench: <http://localhost/vocabulary/bench/>
PREFIX swrc:  <http://swrc.ontoware.org/ontology#>

SELECT ?article
WHERE {
  ?article rdf:type bench:Article .
  ?article ?property ?value
  FILTER (?property=swrc:month)
}
)
    end

    example "sp2b-q3b-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      repository = 'sp2b-50k'
      expected = [
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal2/1960/Article64'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal5/1966/Article217'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1942/Article6'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1954/Article11'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal9/1964/Article310'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal3/1955/Article94'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal6/1961/Article182'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1940/Article2'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal4/1964/Article108'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1964/Article9'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal2/1951/Article55'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1965/Article10'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal3/1956/Article72'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal6/1963/Article194'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal9/1964/Article312'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal2/1949/Article45'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal2/1964/Article35'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal2/1954/Article35'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal7/1966/Article267'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal5/1964/Article157'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1940/Article1'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1954/Article22'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1960/Article17'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal1/1963/Article6'),
       },
       {
           :article => RDF::URI('http://localhost/publications/articles/Journal2/1957/Article60'),
       },
      ]

      sparql_query(:graphs => graphs, :query => @query,       # use unordered test
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
