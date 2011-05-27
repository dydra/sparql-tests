# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 12c 50k triples
# 
describe "SP2B" do
  context "query 12c" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
      @query = %q(
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX person: <http://localhost/persons/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>

ASK {
  person:John_Q_Public rdf:type foaf:Person.
}
)
    end

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}
      expected = false

      sparql_query(:user_id => "sp2b.q12c.#{repository[5..-1]}",
                   :graphs => graphs, :query => @query,
                   :repository => repository, :form => :ask).should == expected
    end
  end
end
