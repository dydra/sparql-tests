# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Non-matching triple pattern
# Patterns not in data don't match
# /Users/ben/repos/datagraph/tests/tests/data-r2/basic/bgp-no-match.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#bgp-no-match
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0087/14-dawg-minutes.html
#
describe "W3C test " do
  context "basic" do
    before :all do
      @data = %q{
@prefix : <http://example.org/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .

:john a foaf:Person ;
   foaf:name "John Smith" .



}
      @query = %q{
PREFIX : <http://example.org/>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
SELECT ?x
WHERE {
  ?x foaf:name "John Smith" ;
       a foaf:Womble .
}


}
    end

    it "Non-matching triple pattern" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'basic-bgp-no-match'
      results = [
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
