# coding: utf-8
#
require 'spec_helper'

# SP2B Query 11 50k triples
# 
describe "SP2B" do
  context "query 11" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/sp2b-50k.nt'
      
      @query = %q(
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?ee
WHERE {
  ?publication rdfs:seeAlso ?ee
}
ORDER BY ?ee
LIMIT 10
OFFSET 50
)
    end

    example "sp2b-q11-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      repository = 'sp2b-50k'
      expected = [
      ]

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
