# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 3a 50k triples
# 
describe "SP2B" do
  context "query 3a" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
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

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}
      expected_length =
        case repository
        when "sp2b-10k" then 846
        when 'sp2b-50k' then 3647
        when 'sp2b-250k' then 15853
        when 'sp2b-1m' then 52676
        when 'sp2b-10m' then -1 # unknown
        when 'sp2b-25m' then 594890
        else raise "Invalid repository: #{repository}"
        end

      sparql_query(:graphs => graphs, :query => @query,       # test length only
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
