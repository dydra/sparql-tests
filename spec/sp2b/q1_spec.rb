# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 1 50k triples
# 
describe "SP2B" do
  context "query 1" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.n3'

      @query = %q(
PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX dc:      <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX bench:   <http://localhost/vocabulary/bench/>
PREFIX xsd:     <http://www.w3.org/2001/XMLSchema#> 

SELECT ?yr
WHERE {
  ?journal rdf:type bench:Journal .
  ?journal dc:title "Journal 1 (1940)"^^xsd:string .
  ?journal dcterms:issued ?yr 
}
)
    end

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :n3}
      expected = [
         {
           :yr => RDF::Literal.new('1940', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
         },
      ]

      # unordered comparison in rspec is =~
      sparql_query(:user_id => "sp2b.q1.#{repository[5..-1]}",
                   :graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).should =~ expected

    end
  end
end
