# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# All: Distinct
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/distinct/distinct-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#distinct-9
#
#
# 
# This test is approved: http://www.w3.org/2007/07/17-dawg-minutes
#
describe "W3C test " do
  context "distinct" do
    before :all do
      @data = %q{
## data-num.ttl
@prefix :         <http://example/> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .

:x1 :p1 "1"^^xsd:integer .
:x1 :p2 "1"^^xsd:integer .

:x2 :p1 "1"^^xsd:integer .
:x2 :p2 "1"^^xsd:integer .

:x3 :p1 "01"^^xsd:integer .
:x3 :p2 "01"^^xsd:integer .

:x4 :p1 "+1"^^xsd:integer .
:x4 :p2 "+1"^^xsd:integer .

:y1 :p1 "1.0"^^xsd:decimal .
:y1 :p2 "1.0"^^xsd:decimal .

:y2 :p1 "+1.0"^^xsd:decimal .
:y2 :p2 "+1.0"^^xsd:decimal .

:y3 :p1 "01.0"^^xsd:decimal .
:y3 :p2 "01.0"^^xsd:decimal .

:z1 :p1 "1.0e0"^^xsd:double .
:z1 :p2 "1.0e0"^^xsd:double .

:z2 :p1 "1.0e0"^^xsd:double .
:z2 :p2 "1.0e0"^^xsd:double .

:z3 :p1 "1.3e0"^^xsd:double .
:z3 :p2 "1.3e0"^^xsd:double .

:z4 :p1 "1.3e0"^^xsd:double .
:z5 :p1 "1.3e0"^^xsd:float .

## data-str.ttl

:x1 :p "abc" .
:x1 :q "abc" .

:x2 :p "abc"@en .
:x2 :q "abc"@en .

:x3 :p "ABC" .
:x3 :q "ABC" .

:x4 :p "ABC"@en .
:x4 :q "ABC"@en .


:x5 :p "abc"^^xsd:string .
:x5 :q "abc"^^xsd:string .
:x6 :p "ABC"^^xsd:string .
:x6 :q "ABC"^^xsd:string .

:x7 :p "" .
:x7 :q "" .

:x8 :p ""@en .
:x8 :q ""@en .

:x9 :p ""^^xsd:string .
:x9 :q ""^^xsd:string .

## data-node.ttl

:x1 :p1 :z1 .
:x1 :p1 _:a .

:x1 :p2 :z1 .
:x1 :p2 _:a .


}
      @query = %q{
PREFIX :      <http://example/> 
PREFIX xsd:   <http://www.w3.org/2001/XMLSchema#>

SELECT DISTINCT ?v
{
    ?x ?p ?v .
}

}
    end

    it "All: Distinct" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'distinct-distinct-9'
      results = [
          { 
              "v" => RDF::Literal.new('ABC' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              "v" => RDF::Literal.new('1.3e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#float')),
          },
          { 
              "v" => RDF::Literal.new('abc' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              "v" => RDF::Literal.new('1.3e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
          },
          { 
              "v" => RDF::Literal.new('ABC' ),
          },
          { 
              "v" => RDF::Literal.new('+1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "v" => RDF::Literal.new('01.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              "v" => RDF::Literal.new('ABC' ),
          },
          { 
              "v" => RDF::Literal.new('01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "v" => RDF::Literal.new('' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              "v" => RDF::Literal.new('1.0e0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
          },
          { 
              "v" => RDF::Literal.new('+1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              "v" => RDF::Literal.new('abc' ),
          },
          { 
              "v" => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "v" => RDF::Literal.new('' ),
          },
          { 
              "v" => RDF::Literal.new('1.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              "v" => RDF::Node.new('b0'),
          },
          { 
              "v" => RDF::URI('http://example/z1'),
          },
          { 
              "v" => RDF::Literal.new('abc' ),
          },
          { 
              "v" => RDF::Literal.new('' ),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
