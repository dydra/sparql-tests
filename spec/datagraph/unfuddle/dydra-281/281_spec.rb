# coding: utf-8
#
require 'spec_helper'

# Test sort (esp. blank node) ordering
# 
#

describe "unfuddle ticket" do
  context "281" do
    before :all do
      @query_by_subject = %q{
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
PREFIX  foaf:       <http://xmlns.com/foaf/0.1/>

SELECT ?x
WHERE {
  ?x foaf:mbox ?y .
}
ORDER by ?x
}

      @query_by_subject_object = %q{
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX  foaf:       <http://xmlns.com/foaf/0.1/>
SELECT ?x ?y
WHERE {
  ?x foaf:mbox ?y .
      }
ORDER by ?x ?y
}

      @query_by_object = %q{
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX  foaf:       <http://xmlns.com/foaf/0.1/>
SELECT ?x ?y
WHERE {
  ?x rdf:type foaf:Person .
  OPTIONAL { ?x foaf:knows ?y } .
      }
ORDER by ?y
}
    end

    example "order blank node subjects" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}
      repository = 'bnode-coreference-dawg-bnode-coref-001' # dawg test
      expected = [
                  { :x => RDF::Node.new('alice') },
                  { :x => RDF::Node.new('bob') },
                  { :x => RDF::Node.new('bob') },
                  { :x => RDF::Node.new('fred') },
                 ]

      sparql_query(:graphs => graphs, :query => @query_by_subject,
                   :repository => repository, :form => :select).should == expected
    end

    example "order blank node subjects and literal objects" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}
      repository = 'bnode-coreference-dawg-bnode-coref-001' # dawg test
      expected = [
                  { :x => RDF::Node.new('alice'),
                    :y => RDF::URI('mailto:alice@work') },
                  { :x => RDF::Node.new('bob'),
                    :y => RDF::URI('mailto:bob@home') },
                  { :x => RDF::Node.new('bob'),
                    :y => RDF::URI('mailto:bob@work') },
                  { :x => RDF::Node.new('fred'),
                    :y => RDF::URI('mailto:fred@edu') },
                 ]

      sparql_query(:graphs => graphs, :query => @query_by_subject_object,
                   :repository => repository, :form => :select).should == expected
    end

    example "order blank node objects" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}
      repository = 'bnode-coreference-dawg-bnode-coref-001' # dawg test
      expected = [
                  { :x => RDF::Node.new('fred'), },
                  { :x => RDF::Node.new('bob'),
                    :y => RDF::Node.new('alice') },
                  { :x => RDF::Node.new('alice'),
                    :y => RDF::Node.new('bob') },
                  { :x => RDF::Node.new('eve'),
                    :y => RDF::Node.new('fred') },
                 ]

      sparql_query(:graphs => graphs, :query => @query_by_object,
                   :repository => repository, :form => :select).should == expected
    end
  end
end
