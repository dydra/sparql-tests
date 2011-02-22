# coding: utf-8
#
require 'spec_helper'

# SP2B Query 12a 50k triples
# 
describe "SP2B" do
  context "query 12a" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/sp2b-50k.nt'
      
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

    example "sp2b-q12a-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      repository = 'sp2b-50k'
      expected = true

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).should == expected
    end
  end
end
