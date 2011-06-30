# coding: utf-8
#
require 'spec_helper'

# Test literal filter arguments
# 
#

describe "unfuddle ticket" do
  context "293" do
    before :all do
      @data = %q{
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_10> "text/vnd.wap.emn+xml" .
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_11> "text/vnd.wap.si" .
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_12> "text/vnd.wap.sl" .
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_13> "text/vnd.wap.wml" .
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_14> "x-wap-application:wml.ua" .
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_15> "x-wap-application:drm.ua" .
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_16> "*" .
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_1> "application/vnd.wap.connectivity-wbxml" .
_:g28841980 <http://www.w3.org/1999/02/22-rdf-syntax-ns#_2> "application/vnd.wap.emn+wbxml" .
}

     @query = %q{

select distinct * where {
  ?s ?p ?o
} ORDER BY ?p
}
    end

    example "w/ filter" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'dydra-293'
      expected_length = 9

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end


