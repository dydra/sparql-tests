# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sameTerm-not-eq
# !sameTerm(?v1, ?v2) && ?v1 = ?v2
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-builtin/sameTerm-not-eq.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#sameTerm-not-eq
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0118/04-dawg-minutes.html
#
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
(select (?x1 ?v1 ?x2 ?v2)
   (filter (&& (! (sameTerm ?v1 ?v2)) (= ?v1 ?v2))
    (bgp
      (triple ?x1 :p ?v1)
      (triple ?x2 :p ?v2)
    )))

}
    end

    example "sameTerm-not-eq", :arithmetic => 'boxed' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'expr-builtin-sameTerm-not-eq'
      expected = [
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd2'),
              :x2 => RDF::URI('http://example.org/things#xi2'),
          },
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd2'),
              :x2 => RDF::URI('http://example.org/things#xd1'),
          },
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd2'),
              :x2 => RDF::URI('http://example.org/things#xi3'),
          },
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd2'),
              :x2 => RDF::URI('http://example.org/things#xd3'),
          },
          { 
              :v1 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd2'),
              :x2 => RDF::URI('http://example.org/things#xi1'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi2'),
              :x2 => RDF::URI('http://example.org/things#xd2'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi2'),
              :x2 => RDF::URI('http://example.org/things#xd1'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi2'),
              :x2 => RDF::URI('http://example.org/things#xi3'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi2'),
              :x2 => RDF::URI('http://example.org/things#xd3'),
          },
          { 
              :v1 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd1'),
              :x2 => RDF::URI('http://example.org/things#xd2'),
          },
          { 
              :v1 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd1'),
              :x2 => RDF::URI('http://example.org/things#xi2'),
          },
          { 
              :v1 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd1'),
              :x2 => RDF::URI('http://example.org/things#xi3'),
          },
          { 
              :v1 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd1'),
              :x2 => RDF::URI('http://example.org/things#xd3'),
          },
          { 
              :v1 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd1'),
              :x2 => RDF::URI('http://example.org/things#xi1'),
          },
          { 
              :v1 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi3'),
              :x2 => RDF::URI('http://example.org/things#xd2'),
          },
          { 
              :v1 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi3'),
              :x2 => RDF::URI('http://example.org/things#xi2'),
          },
          { 
              :v1 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi3'),
              :x2 => RDF::URI('http://example.org/things#xd1'),
          },
          { 
              :v1 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi3'),
              :x2 => RDF::URI('http://example.org/things#xd3'),
          },
          { 
              :v1 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi3'),
              :x2 => RDF::URI('http://example.org/things#xi1'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd3'),
              :x2 => RDF::URI('http://example.org/things#xd2'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd3'),
              :x2 => RDF::URI('http://example.org/things#xi2'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xd3'),
              :x2 => RDF::URI('http://example.org/things#xd1'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd3'),
              :x2 => RDF::URI('http://example.org/things#xi3'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xd3'),
              :x2 => RDF::URI('http://example.org/things#xi1'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi1'),
              :x2 => RDF::URI('http://example.org/things#xd2'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi1'),
              :x2 => RDF::URI('http://example.org/things#xd1'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x1 => RDF::URI('http://example.org/things#xi1'),
              :x2 => RDF::URI('http://example.org/things#xi3'),
          },
          { 
              :v1 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :v2 => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
              :x1 => RDF::URI('http://example.org/things#xi1'),
              :x2 => RDF::URI('http://example.org/things#xd3'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
