# coding: utf-8
#
require 'spec_helper'

# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/data-r2/dataset/dawg-dataset-12b
describe "W3C test" do
  context "dataset" do
    before :all do
      @query = %q{
        (prefix ((: <http://example/>))
        (prefix ((: <http://example/>))
          (dataset
            (
              <data-g1-dup.ttl> <data-g2-dup.ttl> <data-g3-dup.ttl> <data-g4-dup.ttl>
              (named <data-g1.ttl>) (named <data-g2.ttl>) (named <data-g3.ttl>) (named <data-g4.ttl>))
            (union
              (bgp (triple ?s ?p ?o))
              (graph ?g
                (bgp (triple ?s ?p ?o))))))
      }
    end

    example "dawg-dataset-12b" do
    
      graphs = {}

      repository = 'dawg-dataset-12b'
      expected = [
        {
          :s => RDF::URI("http://example/x"),
          :p => RDF::URI("http://example/q"),
          :o => RDF::Literal(2),
          :g => RDF::URI("data-g2.ttl")
        },
        {
          :s => RDF::URI("http://example/x"),
          :p => RDF::URI("http://example/p"),
          :o => RDF::Literal(1),
        },
        {
          :s => RDF::URI("http://example/x"),
          :p => RDF::URI("http://example/p"),
          :o => RDF::Literal(1),
          :g => RDF::URI("data-g1.ttl")
        },
        {
          :s => RDF::Node.new,
          :p => RDF::URI("http://example/q"),
          :o => RDF::Literal(9),
          :g => RDF::URI("data-g3.ttl")
        },
        {
          :s => RDF::Node.new,
          :p => RDF::URI("http://example/q"),
          :o => RDF::Literal(2),
        },
        {
          :s => RDF::Node.new,
          :p => RDF::URI("http://example/p"),
          :o => RDF::Literal(1),
        },
        {
          :s => RDF::Node.new,
          :p => RDF::URI("http://example/q"),
          :o => RDF::Literal(2),
          :g => RDF::URI("data-g4.ttl")
        },
        {
          :s => RDF::URI("http://example/x"),
          :p => RDF::URI("http://example/q"),
          :o => RDF::Literal(2),
        },
        {
          :s => RDF::URI("http://example/a"),
          :p => RDF::URI("http://example/p"),
          :o => RDF::Literal(9),
          :g => RDF::URI("data-g1.ttl")
        },
        {
          :s => RDF::Node.new,
          :p => RDF::URI("http://example/p"),
          :o => RDF::Literal(9),
        },
        {
          :s => RDF::Node.new,
          :p => RDF::URI("http://example/p"),
          :o => RDF::Literal(1),
          :g => RDF::URI("data-g3.ttl")
        },
        {
          :s => RDF::URI("http://example/a"),
          :p => RDF::URI("http://example/p"),
          :o => RDF::Literal(9),
        },
      ]

      sparql_query(:graphs => graphs, :query => @query, :base_uri => File.expand_path(__FILE__),
                   :repository => repository, :form => :select).should =~ expected

    end
  end
end
