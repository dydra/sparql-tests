# coding: utf-8
#
require 'spec_helper'

# SP2B Query 9 50k triples
# 
describe "SP2B" do
  context "query 9" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/sp2b-50k.nt'
      
      @query = %q(
PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

SELECT DISTINCT ?predicate
WHERE {
  {
    ?person rdf:type foaf:Person .
    ?subject ?predicate ?person
  } UNION {
    ?person rdf:type foaf:Person .
    ?person ?predicate ?object
  }
}
)
    end

    example "sp2b-q9-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      repository = 'sp2b-50k'
      expected = [
                  {
                    :predicate => RDF::URI('http://purl.org/dc/elements/1.1/creator')
                  },
                  {
                    :predicate => RDF::URI('http://swrc.ontoware.org/ontology#editor')
                  },
                  {
                    :predicate => RDF::URI('http://xmlns.com/foaf/0.1/name')
                  },
                  {
                    :predicate => RDF::URI('http://www.w3.org/1999/02/22-rdf-syntax-ns#type')
                  },
             ]

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
