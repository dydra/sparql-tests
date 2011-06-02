# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 12a 50k triples
# 
describe "SP2B" do
  context "query 12a" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
      @query = %q(
PREFIX rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX foaf:  <http://xmlns.com/foaf/0.1/>
PREFIX bench: <http://localhost/vocabulary/bench/>
PREFIX dc:    <http://purl.org/dc/elements/1.1/>

ASK {
  ?article rdf:type bench:Article .
  ?article dc:creator ?person1 .
  ?inproc  rdf:type bench:Inproceedings .
  ?inproc  dc:creator ?person2 .
  ?person1 foaf:name ?name1 .
  ?person2 foaf:name ?name2
  FILTER (?name1=?name2)
}
)
    end

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}
      expected = true

      sparql_query(:user_id => "sp2b.q12a.#{repository[5..-1]}",
                   :graphs => graphs, :query => @query,
                   :repository => repository, :form => :ask).should == expected
    end
  end
end
