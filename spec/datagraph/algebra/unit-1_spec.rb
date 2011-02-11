# coding: utf-8
#
require 'spec_helper'

# Unit
# 
# Test that an empty where returns a unit table
# staus bug : the sse-based client  fails on the result : (nil nil)

describe "datagraph test" do
  context "unit1" do
    before :all do
      @data = %q{
@prefix :    <http://example.org/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

<xsd:float> :number  "10.0"^^xsd:float .
<xsd:double> :number  "10.0"^^xsd:double .
<xsd:integer> :number  "40"^^xsd:integer .
<xsd:string> :string "10" .

}
      @query = %q{
PREFIX :    <http://example.org/ns#>
PREFIX xsd: <http://example.org/ns#>

SELECT *
WHERE { }

}
    end

    example "Table", :status => 'bug' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'table-unit'
      expected = [
          { 
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).should == expected
    end
  end
end
