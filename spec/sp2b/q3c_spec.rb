# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 3c 50k triples
# 
describe "SP2B" do
  context "query 3c" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
      @query = %q(
PREFIX rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX swrc:  <http://swrc.ontoware.org/ontology#>
PREFIX bench: <http://localhost/vocabulary/bench/>

SELECT ?article
WHERE {
  ?article rdf:type bench:Article .
  ?article ?property ?value
  FILTER (?property=swrc:isbn)
}
)
    end

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}
      expected = [
      ]

      sparql_query(:graphs => graphs, :query => @query,       # use unordered test
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
