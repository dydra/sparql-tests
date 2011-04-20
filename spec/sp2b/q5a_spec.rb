# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 5a 50k triples
# 
describe "SP2B" do
  context "query 5a" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
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
  ?inproc dc:creator ?person2 .
  ?person foaf:name ?name .
  ?person2 foaf:name ?name2
  FILTER (?name=?name2)
}
)
    end

    example "for #{repository}; full join" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}
      expected_length =
        case repository
        when 'sp2b-10k'  then 155
        when 'sp2b-50k'  then 1085
        when 'sp2b-250k' then 6904
        when 'sp2b-1m'   then 35241
        when 'sp2b-10m'  then -1 # not yet known
        when 'sp2b-25m'  then 696681
        else raise Error "Invalid repository: #{repository}"
        end

      sparql_query(:graphs => graphs, :query => @query,       # test length only
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
