# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# UCASE()
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/functions/ucase01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#ucase01
#
# This test is approved: 
# 
 
describe "W3C test" do
  context "functions" do
    before :all do
      @data = %q{
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix : <http://example.org/> .

# numeric data
:n4 :num -2 .
:n1 :num -1 .
:n2 :num -1.6 .
:n3 :num 1.1 .
:n5 :num 2.5 .

# string data
:s1 :str "foo" .
:s2 :str "bar"@en .
:s3 :str "BAZ" .
:s4 :str "食べ物" .
:s5 :str "100%" .
:s6 :str "abc"^^xsd:string .
:s7 :str "DEF"^^xsd:string .

# date data
:d1 :date "2010-06-21T11:28:01Z"^^xsd:dateTime .
:d2 :date "2010-12-21T15:38:02-08:00"^^xsd:dateTime .
:d3 :date "2008-06-20T23:59:00Z"^^xsd:dateTime .
:d4 :date "2011-02-01T01:02:03"^^xsd:dateTime .

}
      @query = %q{
PREFIX : <http://example.org/>
SELECT ?s (UCASE(?str) AS ?ustr) WHERE {
	?s :str ?str
}

}
    end

    example "UCASE()", :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'functions-ucase01'
      expected = [
          { 
              :s => RDF::URI('http://example.org/s2'),
              :ustr => RDF::Literal.new('BAR' , :language => 'en'),
          },
          { 
              :s => RDF::URI('http://example.org/s4'),
              :ustr => RDF::Literal.new('食べ物' ),
          },
          { 
              :s => RDF::URI('http://example.org/s7'),
              :ustr => RDF::Literal.new('DEF'),
          },
          { 
              :s => RDF::URI('http://example.org/s3'),
              :ustr => RDF::Literal.new('BAZ' ),
          },
          { 
              :s => RDF::URI('http://example.org/s5'),
              :ustr => RDF::Literal.new('100%' ),
          },
          { 
              :s => RDF::URI('http://example.org/s6'),
              :ustr => RDF::Literal.new('ABC'),
          },
          { 
              :s => RDF::URI('http://example.org/s1'),
              :ustr => RDF::Literal.new('FOO' ),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
