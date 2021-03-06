# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# jsonres03 - JSON Result Format
# ASK - answer: true
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/json-res/jsonres03.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#jsonres03
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "json-res" do
    before :all do
      @data = %q{
@prefix : <http://example.org/> .

:s1 :p1 :s2 .
:s2 :p2 "foo" .
:s3 :p3 _:b .
:s4 :p4 4 .

}
      @query = %q{
PREFIX : <http://example.org/>

ASK WHERE { :s1 :p1 :s2 }
}
    end

    example "jsonres03 - JSON Result Format", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'json-res-jsonres03'
      expected = true

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :ask).should == expected
    end
  end
end
