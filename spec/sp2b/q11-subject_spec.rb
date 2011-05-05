# coding: utf-8
#
require 'spec_helper'

# SP2B Query 11 50k triples
# 
describe "SP2B" do
  context "query 11" do
    before :all do
      @repository = ENV['REPOSITORY'] || 'sp2b-50k'
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + @repository + '.nt'
      
      @query = %q(
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?predicate ?ee
WHERE {
  <http://localhost/publications/inprocs/Proceeding5/1974/Inproceeding226> ?predicate ?ee
}
)
    end

    example "single subject" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}

      expected = 9

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => @repository, :form => :select).length.should == expected
    end
  end
end
