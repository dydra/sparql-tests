# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# dawg-construct-identity
# Graph equivalent result graph
# /Users/ben/repos/datagraph/tests/tests/data-r2/construct/query-ident.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#construct-1
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0047/31-dawg-minutes
#
# 20101219 jaa : bug indicator : construct not yet supported by the front-end

describe "W3C test" do
  context "construct" do
    before :all do
      @data = %q{
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .
@prefix rdf:        <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:	    <http://www.w3.org/2000/01/rdf-schema#> .

_:alice
    rdf:type        foaf:Person ;
    foaf:name       "Alice" ;
    foaf:mbox       <mailto:alice@work> ;
    foaf:knows      _:bob ;
    .

_:bob
    rdf:type        foaf:Person ;
    foaf:name       "Bob" ; 
    foaf:knows      _:alice ;
    foaf:mbox       <mailto:bob@work> ;
    foaf:mbox       <mailto:bob@home> ;
    .

}
      @query = %q{
(construct ((triple ?s ?p ?o))
  (project (?s ?p ?o)
    (bgp (triple ?s ?p ?o))))

}
    end

    example "dawg-construct-identity", :status => 'bug' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'construct-construct-1'


        raise NotImplementedError("This test form is not yet implemented")
    end
  end
end
