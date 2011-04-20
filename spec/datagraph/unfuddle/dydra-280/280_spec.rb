# coding: utf-8
#
require 'spec_helper'

# Test literal filter arguments
# 
#

describe "unfuddle ticket" do
  context "280" do
    before :all do
     @url = 'http://public.datagraph.org.s3.amazonaws.com/bsbm-pc100.nt'
     @query = %q{
PREFIX bsbm: <http://www4.wiwiss.fu-berlin.de/bizer/bsbm/v01/vocabulary/>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select distinct ?property where {
 ?offer rdf:type bsbm:Offer .
 ?offer ?property ?product .
 FILTER ( ?property != rdf:type )
} 
}
    end

    example "w/ filter" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :nt}


      repository = 'bsbm-pc100'
      expected_length = 9

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
