# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# One optional clause
# One optional clause
# /Users/ben/repos/datagraph/tests/tests/data-r2/optional/q-opt-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-optional-001
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/0006
#
describe "W3C test " do
  context "optional" do
    before :all do
      @data = %q{
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .

_:a foaf:mbox   <mailto:alice@example.net> .
_:a foaf:name   "Alice" .
_:a foaf:nick   "WhoMe?" .

_:b foaf:mbox   <mailto:bert@example.net> .
_:b foaf:name   "Bert" .

_:e foaf:mbox   <mailto:eve@example.net> .
_:e foaf:nick   "DuckSoup" .

}
      @query = %q{
PREFIX  foaf:   <http://xmlns.com/foaf/0.1/>

SELECT ?mbox ?name
   {
     ?x foaf:mbox ?mbox .
     OPTIONAL { ?x foaf:name  ?name } .
   }

}
    end

    it "One optional clause" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'optional-dawg-optional-001'
      results = [
          { 
              "name" => RDF::Literal.new('Alice' ),
              "mbox" => RDF::URI('mailto:alice@example.net'),
          },
          { 
              "mbox" => RDF::URI('mailto:eve@example.net'),
          },
          { 
              "name" => RDF::Literal.new('Bert' ),
              "mbox" => RDF::URI('mailto:bert@example.net'),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
