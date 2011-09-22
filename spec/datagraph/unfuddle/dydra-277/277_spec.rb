# coding: utf-8
#
require 'spec_helper'

# Test literal filter arguments
# 
#

describe "unfuddle ticket" do
  context "277" do
    before :all do
     @data = %q{

@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

_:genid2 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/sale> .
<http://example.org/bike> <http://example.org/has_wheels> "true"^^xsd:boolean .
<http://example.org/alice> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/cust> .
_:genid4 <http://example.org/sold> <http://example.org/nature> .
<http://example.org/car> <http://example.org/has_wheels> "true"^^xsd:boolean .
<http://example.org/bike> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/item> .
_:genid1 <http://example.org/sold> <http://example.org/nature> .
_:genid1 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/sale> .
<http//example.org/steve> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/cust> .
_:genid1 <http://example.org/sold> <http://example.org/gardening> .
_:genid4 <http://example.org/sold> <http://example.org/hunting> .
_:genid3 <http://example.org/sold> <http://example.org/nature> .
<http//example.org/hunting> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/book> .
<http://example.org/truck> <http://example.org/color> "blue" .
<http://example.org/truck> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/item> .
<http://example.org/gardening> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/book> .
<http://example.org/fishing> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/book> .
<http://example.org/john> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/cust> .
_:genid3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/sale> .
_:genid4 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/sale> .
<http://example.org/nature> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/book> .
<http://example.org/bike> <http://example.org/color> "red" .
<http://example.org/stereo> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/item> .
<http://example.org/car> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/item> .
<http://example.org/car> <http://example.org/color> "red" .
<http://example.org/truck> <http://example.org/has_wheels> "true"^^xsd:boolean .
<http://example.org/bob> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://example.org/cust> .
_:genid3 <http://example.org/sold> <http://example.org/hunting> .
}
     @query1 = %q{
PREFIX : <http://example.org/>

SELECT  (count(?feature) as ?fCount) 
        (sample(?product2) as ?product)
where {
 :car ?feature ?featureValue .
 ?product2 a :item .
 filter ( ?feature != rdf:type )
 filter ( ?product2 != :car )
 ?product2 ?feature ?featureValue .
} 
group by ?product2
order by ?fCount
}
     @query2 = %q{
PREFIX : <http://example.org/>

SELECT  (count(?feature) as ?fCount) 
        (sample(?product2) as ?product)
where {
 :car ?feature ?featureValue .
 ?product2 a :item .
 ?product2 ?feature ?featureValue .
 filter ( ?feature != rdf:type )
 filter ( ?product2 != :car )
} 
group by ?product2
order by ?fCount
}
    end

    example "filter location" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'dydra-277'
      result1 = sparql_query(:graphs => graphs, :query => @query1, :repository => repository, :form => :select)
      result2 = sparql_query(:graphs => graphs, :query => @query2, :repository => repository, :form => :select)
      result1.should == result2
    end
  end
end
