# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Optional-filter - scope of variable
# FILTERs in an OPTIONAL do not extend to variables bound outside of the LeftJoin(...) operation
# /Users/ben/repos/datagraph/tests/tests/data-r2/algebra/opt-filter-3.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#opt-filter-3
#
# This test is approved: 
# http://www.w3.org/2007/06/19-dawg-minutes.html
#
# 20120217 jaa : added undefined:unbound/error
# 20140129 jaa : added pragma

describe "W3C test" do
  context "algebra" do
    before :all do
      @data = %q{
@prefix   :         <http://example/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x1 :p "1"^^xsd:integer .
:x2 :p "2"^^xsd:integer .

:x3 :q "3"^^xsd:integer .
:x3 :q "4"^^xsd:integer .
 

}
      @query = %q{
PREFIX :    <http://example/>
PREFIX undefinedVariableBehavior: <urn:dydra:error>

SELECT *
{ 
    :x1 :p ?v . 
    { :x3 :q ?w 
      # ?v is not in scope so ?v2 never set
      OPTIONAL {  :x1 :p ?v2 FILTER(?v = 1) }
    }
}

}
    end

    example "Optional-filter - scope of variable: undefined=error", :undefined => 'error' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'algebra-opt-filter-3'

      lambda { sparql_query(:graphs => graphs, :query => @query,       
                            :repository => repository, :form => :select)}.should raise_error
    end
  end
end
