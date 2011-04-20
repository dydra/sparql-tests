# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 10 50k triples
# 
describe "SP2B" do
  context "query 10" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
      @query = %q(
PREFIX person: <http://localhost/persons/>

SELECT ?subject ?predicate
WHERE {
  ?subject ?predicate person:Paul_Erdoes
}
)
    end

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}

      expected_length =
        case repository
        when 'sp2b-10k'  then 166
        when 'sp2b-50k'  then 307
        when 'sp2b-250k' then 452
        when 'sp2b-1m'   then 572
        when 'sp2b-10m'  then 656
        when 'sp2b-25m'  then 656
        else raise "Invalid repository: #{repository}"
        end

      sparql_query(:graphs => graphs, :query => @query,       # test length only
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
