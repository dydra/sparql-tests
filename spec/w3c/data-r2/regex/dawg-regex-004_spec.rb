# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# regex-query-004
# str()+URI test
# /Users/ben/repos/datagraph/tests/tests/data-r2/regex/regex-query-004.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-regex-004
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/0029.html
#
describe "W3C test " do
  context "regex" do
    before :all do
      @data = %q{
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix ex: <http://example.com/#> .

ex:foo rdf:value "abcDEFghiJKL" , "ABCdefGHIjkl", "0123456789",
	<http://example.com/uri>, "http://example.com/literal" .

}
      @query = %q{
PREFIX  rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX  ex: <http://example.com/#>
SELECT ?val
WHERE {
	ex:foo rdf:value ?val .
	FILTER regex(str(?val), "example\\.com")
}

}
    end

    it "regex-query-004" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'regex-dawg-regex-004'
      results = [
          { 
              "val" => RDF::Literal.new('http://example.com/literal' ),
          },
          { 
              "val" => RDF::URI('http://example.com/uri'),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
