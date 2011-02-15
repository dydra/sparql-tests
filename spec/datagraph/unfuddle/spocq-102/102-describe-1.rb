# coding: utf-8
#
require 'spec_helper'

describe "unfuddle ticket" do
  context "spocq 102" do
    before :all do
      @data = %q{
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

<http://www.example.org/instance#a>
    <http://www.example.org/schema#p> 1 ;
    <http://www.example.org/schema#q> 2 .

<http://www.example.org/instance#b>
    <http://www.example.org/schema#p> 3 .
}
      @query = %q{
describe <http://www.example.org/instance#a>
}
    end

    example "simple escapes" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = '102-describe'
      expected = RDF::Graph.new do |graph|
        graph << RDF::Statement.new(
          :subject => RDF::URI('http://www.example.org/instance#a'),
          :predicate => RDF::URI('http://www.example.org/schema#p'),
          :object => RDF::Literal.new(1))
        graph << RDF::Statement.new(
          :subject => RDF::URI('http://www.example.org/instance#a'),
          :predicate => RDF::URI('http://www.example.org/schema#q'),
          :object => RDF::Literal.new(2))

      end

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :describe).should be_isomorphic_with expected
    end
  end
end
