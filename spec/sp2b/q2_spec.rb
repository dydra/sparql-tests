# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 2 50k triples
# 
describe "SP2B" do
  context "query 2" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
      @query = %q(
PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs:    <http://www.w3.org/2000/01/rdf-schema#>
PREFIX swrc:    <http://swrc.ontoware.org/ontology#>
PREFIX foaf:    <http://xmlns.com/foaf/0.1/>
PREFIX bench:   <http://localhost/vocabulary/bench/>
PREFIX dc:      <http://purl.org/dc/elements/1.1/>
PREFIX dcterms: <http://purl.org/dc/terms/>

SELECT ?inproc ?author ?booktitle ?title 
       ?proc ?ee ?page ?url ?yr ?abstract
WHERE {
  ?inproc rdf:type bench:Inproceedings .
  ?inproc dc:creator ?author .
  ?inproc bench:booktitle ?booktitle .
  ?inproc dc:title ?title .
  ?inproc dcterms:partOf ?proc .
  ?inproc rdfs:seeAlso ?ee .
  ?inproc swrc:pages ?page .
  ?inproc foaf:homepage ?url .
  ?inproc dcterms:issued ?yr 
  OPTIONAL {
    ?inproc bench:abstract ?abstract
  }
}
ORDER BY ?yr
)
    end

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}
      expected_length =
        case repository
        when 'sp2b-10k'  then 147
        when 'sp2b-50k'  then 965
        when 'sp2b-250k' then 6197
        when 'sp2b-1m'   then 32770
        when 'sp2b-10m'  then -1 # not yet known
        when 'sp2b-25m'  then 1876999
        else raise "Invalid repository: #{repository}"
        end

      sparql_query(:graphs => graphs, :query => @query,       # test just the length
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
