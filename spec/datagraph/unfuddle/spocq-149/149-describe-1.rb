# coding: utf-8
#
require 'spec_helper'

describe "unfuddle" do
  context "spocq 149" do
    before :all do
      @data = %q{
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://www.example.org/instance#a>
    <http://www.example.org/schema#p> ( 1.1 1.2 1.3 1.4 1.5) ;
    <http://www.example.org/schema#q> 2 .
}
      @query = %q{
# limit the describe depth to 3 of 5 possible
PREFIX pragma_DescribeSubjectDepth: <http://www.w3.org/1999/02/22-rdf-syntax-ns#_3>
describe ?s
where { ?s <http://www.example.org/schema#p> ?o }
}
    end

    example "describe subject with blank nodes with limit" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = '149-describe-1'
      expected = RDF::Graph.load(File.dirname(__FILE__) + "/result.nt")

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :describe).should be_isomorphic_with expected
    end
  end
end
