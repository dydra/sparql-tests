# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# dawg-triple-pattern-001
# Simple triple match
# /Users/ben/repos/datagraph/tests/tests/data-r2/triple-match/dawg-tp-01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-triple-pattern-001
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2005JanMar/0358
#
describe "W3C test " do
  context "triple-match" do
    before :all do
      @data = %q{
@prefix : <http://example.org/data/> .

:x :p :v1 .
:x :p :v2 .

}
      @query = %q{
PREFIX : <http://example.org/data/>

SELECT *
WHERE { :x ?p ?q . }

}
    end

    it "dawg-triple-pattern-001" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'triple-match-dawg-triple-pattern-001'
      results = [
          { 
              "q" => RDF::URI('http://example.org/data/v2'),
              "p" => RDF::URI('http://example.org/data/p'),
          },
          { 
              "q" => RDF::URI('http://example.org/data/v1'),
              "p" => RDF::URI('http://example.org/data/p'),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
