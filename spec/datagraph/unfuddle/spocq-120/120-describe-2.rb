# coding: utf-8
#
require 'spec_helper'

describe "unfuddle" do
  context "spocq 120" do
    before :all do
      @data = %q{
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://www.example.org/instance#a>
    <http://www.example.org/schema#p> ( 1.1 1.2 ) ;
    <http://www.example.org/schema#q> 2 .

<http://www.example.org/instance#b> <http://www.example.org/instance#m> _:node1 .
_:node1 <http://www.example.org/schema#p> 3 .
_:node1 <http://www.example.org/schema#q> 4 .
}
      @query = %q{
describe ?s
where { ?s <http://www.example.org/schema#p> ?o }
}
    end

    example "describe subject 2 with blank nodes" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = '120-describe-2'
      expected = RDF::Graph.new do |graph|
        graph << RDF::Statement.new(
          :subject => RDF::URI('http://www.example.org/instance#a'),
          :predicate => RDF::URI('http://www.example.org/schema#p'),
          :object => RDF::Literal.new(1))
        graph << RDF::Statement.new(
          :subject => RDF::URI('http://www.example.org/instance#a'),
          :predicate => RDF::URI('http://www.example.org/schema#q'),
          :object => RDF::Literal.new(2))
        graph << RDF::Statement.new(
          :subject => RDF::URI('http://www.example.org/instance#b'),
          :predicate => RDF::URI('http://www.example.org/schema#p'),
          :object => RDF::Literal.new(3))

      end

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :describe).should be_isomorphic_with expected
    end
  end
end
