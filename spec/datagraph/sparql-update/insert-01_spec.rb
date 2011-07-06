# coding: utf-8
#
require 'spec_helper'

# insert-01
# 
# This test is approved: 
# 
#
describe "W3C test" do
  context "basic-update" do
    before :all do
      @data = %q{
<http://example.org/s> <http://example.org/p> "o" .
}
      @query = %q{
PREFIX : <http://www.example.org/>
SELECT * WHERE {
	?s ?p ?o
}
}

      @update = %q{
PREFIX     : <http://example.org/> 

INSERT {
	?s ?p "q"
} WHERE {
	?s ?p ?o
} }
    end

    example "insert-01", :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'aggregates-agg-avg-01'
      expected = [
          { 
              :s => RDF::URI('http://example.org/s'),
              :p => RDF::URI('http://example.org/p'),
              :o => RDF::Literal.new('o' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              :s => RDF::URI('http://example.org/s'),
              :p => RDF::URI('http://example.org/p'),
              :o => RDF::Literal.new('q' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
      ]

      sparql_query(:graphs => graphs, :query => @update, :repository => repository, :form => :ask)

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
