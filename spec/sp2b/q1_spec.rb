# coding: utf-8
#
require 'spec_helper'

# SP2B Query 1 50k triples
# 
describe "SP2B" do
  context "query 1" do
    before :all do
      @repository = ENV['REPOSITORY'] || 'sp2b-50k'
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + @repository + '.nt'

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

    example "sp2b-q1-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      expected = [
         {
           :yr => RDF::Literal.new('1940', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
         },
      ]

      puts(sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => @repository, :form => :select))

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => @repository, :form => :select).should =~ expected

    end
  end
end
