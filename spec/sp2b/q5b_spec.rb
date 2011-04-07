# coding: utf-8
#
require 'spec_helper'

# SP2B Query 5b 50k triples
# 
describe "SP2B" do
  context "query 5b" do
    before :all do
      @repository = ENV['REPOSITORY'] || 'sp2b-50k'
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + @repository + '.nt'
      
      @query = %q(
PREFIX rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX foaf:  <http://xmlns.com/foaf/0.1/>
PREFIX bench: <http://localhost/vocabulary/bench/>
PREFIX dc:    <http://purl.org/dc/elements/1.1/>

SELECT DISTINCT ?person ?name
WHERE {
  ?article rdf:type bench:Article .
  ?article dc:creator ?person .
  ?inproc rdf:type bench:Inproceedings .
  ?inproc dc:creator ?person .
  ?person foaf:name ?name
}
)
    end

    example "sp2b-q5b-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      expected_length = 1085

      sparql_query(:graphs => graphs, :query => @query,       # test length only
                   :repository => @repository, :form => :select).length.should == expected_length
    end
  end
end
