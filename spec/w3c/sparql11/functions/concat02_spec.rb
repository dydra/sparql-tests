# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# CONCAT() 2
# 
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/functions/concat02.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#concat02
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
:s3 :str "english"@en .
:s4 :str "français"@fr .

:s5 :str "abc"^^xsd:string .
:s6 :str "def"^^xsd:string .

:s7 :str 7 .

}
      @query = %q{
PREFIX : <http://example.org/>
SELECT (CONCAT(?str1,?str2) AS ?str) WHERE {
	?s1 :str ?str1 .
	?s2 :str ?str2 .
}

}
    end

    example "CONCAT() 2", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'functions-concat02'
      expected = [
          { 
              :str => RDF::Literal.new('abcabc'),
          },
          { 
              :str => RDF::Literal.new('abcdef'),
          },
          { 
              :str => RDF::Literal.new('defabc'),
          },
          { 
              :str => RDF::Literal.new('defdef'),
          },
          { 
              :str => RDF::Literal.new('englishenglish' , :language => 'en'),
          },
          { 
              :str => RDF::Literal.new('françaisfrançais' , :language => 'fr'),
          },
          { 
              :str => RDF::Literal.new('日本語日本語' , :language => 'ja'),
          },
          { 
              :str => RDF::Literal.new('123abc' ),
          },
          { 
              :str => RDF::Literal.new('123def' ),
          },
          { 
              :str => RDF::Literal.new('123english' ),
          },
          { 
              :str => RDF::Literal.new('123français' ),
          },
          { 
              :str => RDF::Literal.new('123日本語' ),
          },
          { 
              :str => RDF::Literal.new('123123' ),
          },
          { 
              :str => RDF::Literal.new('abc123' ),
          },
          { 
              :str => RDF::Literal.new('abcenglish' ),
          },
          { 
              :str => RDF::Literal.new('abcfrançais' ),
          },
          { 
              :str => RDF::Literal.new('abc日本語' ),
          },
          { 
              :str => RDF::Literal.new('def123' ),
          },
          { 
              :str => RDF::Literal.new('defenglish' ),
          },
          { 
              :str => RDF::Literal.new('deffrançais' ),
          },
          { 
              :str => RDF::Literal.new('def日本語' ),
          },
          { 
              :str => RDF::Literal.new('english123' ),
          },
          { 
              :str => RDF::Literal.new('englishabc' ),
          },
          { 
              :str => RDF::Literal.new('englishdef' ),
          },
          { 
              :str => RDF::Literal.new('englishfrançais' ),
          },
          { 
              :str => RDF::Literal.new('english日本語' ),
          },
          { 
              :str => RDF::Literal.new('français123' ),
          },
          { 
              :str => RDF::Literal.new('françaisabc' ),
          },
          { 
              :str => RDF::Literal.new('françaisdef' ),
          },
          { 
              :str => RDF::Literal.new('françaisenglish' ),
          },
          { 
              :str => RDF::Literal.new('français日本語' ),
          },
          { 
              :str => RDF::Literal.new('日本語123' ),
          },
          { 
              :str => RDF::Literal.new('日本語abc' ),
          },
          { 
              :str => RDF::Literal.new('日本語def' ),
          },
          { 
              :str => RDF::Literal.new('日本語english' ),
          },
          { 
              :str => RDF::Literal.new('日本語français' ),
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
          { 
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
