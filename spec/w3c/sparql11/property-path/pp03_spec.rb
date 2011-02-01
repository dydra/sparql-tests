# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Simple path with loop
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/property-path/pp03.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#pp03
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "property-path" do
    before :all do
      @data = %q{
@prefix rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:	<http://www.w3.org/2000/01/rdf-schema#> .
@prefix ex:	<http://www.example.org/schema#>.
@prefix in:	<http://www.example.org/instance#>.

in:a ex:p1 in:b .
in:b ex:p2 in:a .
in:a ex:p3 in:b .
in:b ex:p4 in:a .




}
      @query = %q{
prefix ex:	<http://www.example.org/schema#>
prefix in:	<http://www.example.org/instance#>

select * where {
in:a ex:p1/ex:p2/ex:p3/ex:p4 ?x
}
}
    end

    example "Simple path with loop", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'property-path-pp03'
      expected = [
          { 
              :x => RDF::URI('http://www.example.org/instance#a'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end