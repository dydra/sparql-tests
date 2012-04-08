# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Filter-scope - 1
# FILTERs in an OPTIONAL do not extend to variables bound outside of the LeftJoin(...) operation
# /Users/ben/repos/datagraph/tests/tests/data-r2/algebra/filter-scope-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#filter-scope-1
#
# This test is approved: 
# http://www.w3.org/2007/06/19-dawg-minutes.html
#
# 20120217 jaa : added undefined:unbound/error

describe "W3C test" do
  context "algebra" do
    before :all do
      @data = %q{
@prefix : <http://example/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x :p "1"^^xsd:integer .
:x :p "2"^^xsd:integer .
:x :p "3"^^xsd:integer .
:x :p "4"^^xsd:integer .

:x :q "1"^^xsd:integer .
:x :q "2"^^xsd:integer .
:x :q "3"^^xsd:integer .

}
      @query = %q{
PREFIX :    <http://example/>

SELECT *
{ 
    :x :p ?v . 
    { :x :q ?w 
      OPTIONAL {  :x :p ?v2 FILTER(?v = 1) }
    }
}

}
    end

    example "Filter-scope - 1 : undefined=error", :undefined => 'error' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'algebra-filter-scope-1'

      lambda { sparql_query(:graphs => graphs, :query => @query,
                            :repository => repository, :form => :select) }.should raise_error
    end
  end
end