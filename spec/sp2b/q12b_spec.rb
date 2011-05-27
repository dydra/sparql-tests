# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 12b 50k triples
# 
describe "SP2B" do
  context "query 12b" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
      @query = %q(
PREFIX xsd:  <http://www.w3.org/2001/XMLSchema#> 
PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX dc:   <http://purl.org/dc/elements/1.1/>

ASK {
  ?erdoes rdf:type foaf:Person .
  ?erdoes foaf:name "Paul Erdoes"^^xsd:string .
  {
    ?document dc:creator ?erdoes .
    ?document dc:creator ?author .
    ?document2 dc:creator ?author .
    ?document2 dc:creator ?author2 .
    ?author2 foaf:name ?name
    FILTER (?author!=?erdoes &&
            ?document2!=?document &&
            ?author2!=?erdoes &&
            ?author2!=?author)
  } UNION {
    ?document dc:creator ?erdoes .
    ?document dc:creator ?author .
    ?author foaf:name ?name 
    FILTER (?author!=?erdoes)
  }
}
)
    end

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}
      expected = true

      sparql_query(:user_id => "sp2b.q12b.#{repository[5..-1]}",
                   :graphs => graphs, :query => @query,
                   :repository => repository, :form => :ask).should == expected
    end
  end
end
