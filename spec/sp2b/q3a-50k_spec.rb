# coding: utf-8
#
require 'spec_helper'

# SP2B Query 3a 50k triples
# 
describe "SP2B" do
  context "query 3a" do
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
  FILTER (?property=swrc:pages) 
}
)
    end

    example "sp2b-q3a-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      repository = 'sp2b-50k'
      expected_length = 3647

      sparql_query(:graphs => graphs, :query => @query,       # test length only
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
