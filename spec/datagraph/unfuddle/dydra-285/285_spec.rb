# coding: utf-8
#
require 'spec_helper'

# Test solution field encoding with null values
# 
#

describe "unfuddle ticket" do
  context "285" do
    before :all do
      @query = %q{
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
PREFIX  foaf:       <http://xmlns.com/foaf/0.1/>

SELECT ?x ?a ?z
WHERE {
  ?a foaf:mbox ?y .
}
ORDER by ?a
}
    end

    example "null columns" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}
      repository = 'bnode-coreference-dawg-bnode-coref-001' # dawg test
      expected = [
                  { :a => RDF::Node.new('alice') },
                  { :a => RDF::Node.new('bob') },
                  { :a => RDF::Node.new('bob') },
                  { :a => RDF::Node.new('fred') },
                 ]

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).should == expected
    end
  end
end
