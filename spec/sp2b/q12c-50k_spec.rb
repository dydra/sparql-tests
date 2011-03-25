# coding: utf-8
#
require 'spec_helper'

# SP2B Query 12c 50k triples
# 
describe "SP2B" do
  context "query 12c" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/sp2b-50k.nt'
      
      @query = %q(
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX person: <http://localhost/persons/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

ASK {
  person:John_Q_Public rdf:type foaf:Person.
}
)
    end

    example "sp2b-q12c-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      repository = 'sp2b-50k'
      expected = false

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :ask).should == expected
    end
  end
end
