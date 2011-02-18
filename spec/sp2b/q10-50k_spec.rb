# coding: utf-8
#
require 'spec_helper'

# SP2B Query 10 50k triples
# 
describe "SP2B" do
  context "query 10" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/sp2b-50k.nt'
      
      @query = %q(
PREFIX person: <http://localhost/persons/>

SELECT ?subject ?predicate
WHERE {
  ?subject ?predicate person:Paul_Erdoes
}
)
    end

    example "sp2b-q10-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      repository = 'sp2b-50k'
      expected_length = 307

      sparql_query(:graphs => graphs, :query => @query,       # test length only
                   :repository => repository, :form => :select).length.should = expected_length
    end
  end
end
