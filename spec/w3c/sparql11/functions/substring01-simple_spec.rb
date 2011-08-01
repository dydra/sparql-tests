# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# SUBSTRING() (3-argument)
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/functions/substring01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#substring01
#
# This test is approved: 
# 20110716 jaa : string=>simple

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
SELECT ?s ?str (SUBSTR(?str,1,1) AS ?substr) WHERE {
	?s :str ?str
}

}
    end

    example "SUBSTRING() (3-argument)", :w3c_status => 'unapproved', :string => 'simple' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'functions-substring01'
      expected = [
          { 
              :s => RDF::URI('http://example.org/s2'),
              :str => RDF::Literal.new('bar' , :language => 'en'),
              :substr => RDF::Literal.new('b' , :language => 'en'),
          },
          { 
              :s => RDF::URI('http://example.org/s4'),
              :str => RDF::Literal.new('食べ物' ),
              :substr => RDF::Literal.new('食' ),
          },
          { 
              :s => RDF::URI('http://example.org/s7'),
              :str => RDF::Literal.new('DEF'),
              :substr => RDF::Literal.new('D'),
          },
          { 
              :s => RDF::URI('http://example.org/s3'),
              :str => RDF::Literal.new('BAZ' ),
              :substr => RDF::Literal.new('B' ),
          },
          { 
              :s => RDF::URI('http://example.org/s5'),
              :str => RDF::Literal.new('100%' ),
              :substr => RDF::Literal.new('1' ),
          },
          { 
              :s => RDF::URI('http://example.org/s6'),
              :str => RDF::Literal.new('abc'),
              :substr => RDF::Literal.new('a'),
          },
          { 
              :s => RDF::URI('http://example.org/s1'),
              :str => RDF::Literal.new('foo' ),
              :substr => RDF::Literal.new('f' ),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
