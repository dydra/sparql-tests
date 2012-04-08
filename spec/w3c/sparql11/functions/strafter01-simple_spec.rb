# coding: utf-8
#
require 'spec_helper'

# strafter01 - 
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2009/sparql/docs/tests/summary.html#strafter01
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "subquery" do
    before :all do
      @data = IO.read(File.dirname(__FILE__) + "/data2.ttl");
      @query = IO.read(File.dirname(__FILE__) + "/strafter01.rq");
    end

    example "strafter01", :status => 'unverified', :w3c_status => 'approved', :string => 'simple' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}

      repository = 'functions-strafter01'
      expected = SPARQL::Client.parse_xml_bindings(IO.read(File.dirname(__FILE__) + "/strafter01-simple.srx")).map{|each| each.to_hash}

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
