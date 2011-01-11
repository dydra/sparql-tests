# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sameTerm-simple
# sameTerm(?v1, ?v2)
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-builtin/sameTerm.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#sameTerm-simple
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0118/04-dawg-minutes.html
#
# 20101220 jaa : arithmetic indicator

describe "W3C test" do
  context "expr-builtin" do
    before :all do
      @data = %q{
@prefix    :        <http://example.org/things#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:xi1 :p  "1"^^xsd:integer .
:xi2 :p  "1"^^xsd:integer .
:xi3 :p  "01"^^xsd:integer .

:xd1 :p  "1.0e0"^^xsd:double .
:xd2 :p  "1.0"^^xsd:double .
:xd3 :p  "1"^^xsd:double .

:xt1 :p  "zzz"^^:myType .

:xp1 :p  "zzz" .
:xp2 :p  "1" .
:xp2 :p  "" .

:xu :p  :z .

:xb :p  _:a .

}
      @query = %q{
# Test: sameTerm
# $Id: sameTerm.rq,v 1.1 2007/08/31 14:01:57 eric Exp $

PREFIX     :    <http://example.org/things#>

SELECT *
{
    ?x1 :p ?v1 .
    ?x2 :p ?v2 .
    FILTER sameTerm(?v1, ?v2)
}

}
    end

    example "sameTerm-simple", :arithmetic => 'native' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'expr-builtin-sameTerm-simple'
      expected = [
          { 
              :v1 => RDF::URI('http://example.org/things#z'),
              :v2 => RDF::URI('http://example.org/things#z'),
              :x1 => RDF::URI('http://example.org/things#xu'),
              :x2 => RDF::URI('http://example.org/things#xu'),
          },
          {
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd1'),
              :x2 => RDF::URI('http://example.org/things#xd1'),
          },
          {
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd1'),
              :x2 => RDF::URI('http://example.org/things#xd3'),
          },
          {
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd1'),
              :x2 => RDF::URI('http://example.org/things#xd2'),
          },
          {
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd2'),
              :x2 => RDF::URI('http://example.org/things#xd1'),
          },
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd2'),
              :x2 => RDF::URI('http://example.org/things#xd2'),
          },
          {
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd2'),
              :x2 => RDF::URI('http://example.org/things#xd3'),
          },
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd3'),
              :x2 => RDF::URI('http://example.org/things#xd1'),
          },
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd3'),
              :x2 => RDF::URI('http://example.org/things#xd2'),
          },
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd3'),
              :x2 => RDF::URI('http://example.org/things#xd3'),
          },
          { 
              :v1 => RDF::Literal.new('zzz' ),
              :v2 => RDF::Literal.new('zzz' ),
              :x1 => RDF::URI('http://example.org/things#xp1'),
              :x2 => RDF::URI('http://example.org/things#xp1'),
          },
          { 
              :v1 => RDF::Literal.new('1' ),
              :v2 => RDF::Literal.new('1' ),
              :x1 => RDF::URI('http://example.org/things#xp2'),
              :x2 => RDF::URI('http://example.org/things#xp2'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi1'),
              :x2 => RDF::URI('http://example.org/things#xi1'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi1'),
              :x2 => RDF::URI('http://example.org/things#xi2'),
          },
          {
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi1'),
              :x2 => RDF::URI('http://example.org/things#xi3'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi2'),
              :x2 => RDF::URI('http://example.org/things#xi1'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi2'),
              :x2 => RDF::URI('http://example.org/things#xi2'),
          },
          {
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi2'),
              :x2 => RDF::URI('http://example.org/things#xi3'),
          },
          {
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi3'),
              :x2 => RDF::URI('http://example.org/things#xi1'),
          },
          {
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi3'),
              :x2 => RDF::URI('http://example.org/things#xi2'),
          },
          { 
              :v1 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi3'),
              :x2 => RDF::URI('http://example.org/things#xi3'),
          },
          { 
              :v1 => RDF::Literal.new('' ),
              :v2 => RDF::Literal.new('' ),
              :x1 => RDF::URI('http://example.org/things#xp2'),
              :x2 => RDF::URI('http://example.org/things#xp2'),
          },
          { 
              :v1 => RDF::Literal.new('zzz' , :datatype => RDF::URI('http://example.org/things#myType')),
              :v2 => RDF::Literal.new('zzz' , :datatype => RDF::URI('http://example.org/things#myType')),
              :x1 => RDF::URI('http://example.org/things#xt1'),
              :x2 => RDF::URI('http://example.org/things#xt1'),
          },
          { 
              :v1 => RDF::Node.new('a'),
              :v2 => RDF::Node.new('a'),
              :x1 => RDF::URI('http://example.org/things#xb'),
              :x2 => RDF::URI('http://example.org/things#xb'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
