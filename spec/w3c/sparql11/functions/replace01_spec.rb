# coding: utf-8
#
require 'spec_helper'

# REPLACE()
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2009/sparql/docs/tests/data-sparql11/functions/replace01.rq
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "functions" do
    before :all do
      @data = %q{
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix : <http://example.org/> .

:s1 :str "123" .
:s2 :str "日本語"@ja .
:s3 :str "English"@en .
:s4 :str "Français"@fr .
:s5 :str "abc"^^xsd:string .
:s6 :str "def"^^xsd:string .
:s7 :str 7 .
:s8 :str "banana" .
:s9 :str "abcd" .
}
      @query = %q{
PREFIX : <http://example.org/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
SELECT ?s (REPLACE(?str,"[^a-z0-9]", "-") AS ?new) WHERE {
	?s :str ?str
}
}
    end

    example "replace01", :w3c_status => 'approved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'functions-replace01'
      expected = [
          { 
              :new => RDF::Literal.new('123'),
              :s => RDF::URI('http://example.org/s1'),
          },
          { 
              :new => RDF::Literal.new('---' , :language => 'ja'),
              :s => RDF::URI('http://example.org/s2'),
          },
          { 
              :new => RDF::Literal.new('-nglish' , :language => 'en'),
              :s => RDF::URI('http://example.org/s3'),
          },
          { 
              :new => RDF::Literal.new('-ran-ais' , :language => 'fr'),
              :s => RDF::URI('http://example.org/s4'),
          },
          { 
              :new => RDF::Literal.new('abc'),
              :s => RDF::URI('http://example.org/s5'),
          },
          { 
              :new => RDF::Literal.new('def'),
              :s => RDF::URI('http://example.org/s6'),
          },
          {
              :s => RDF::URI('http://example.org/s7'),
          },
          { 
              :new => RDF::Literal.new('banana'),
              :s => RDF::URI('http://example.org/s8'),
          },
          { 
              :new => RDF::Literal.new('abcd'),
              :s => RDF::URI('http://example.org/s9'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
