# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# (pp28) Diamond, with loop -- (:p/:p)?
# 
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/property-path/path-3-3.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#pp28
#
# This test is approved: 
# http://www.w3.org/2009/sparql/meeting/2011-03-29#resolution_3
#
describe "W3C test" do
  context "property-path" do
    before :all do
      @data = %q{
@prefix : <http://example/> .

:a :p :b .
:b :p :z .
:a :p :c .
:c :p :z .
:c :p :c .

}
      @query = %q{
prefix : <http://example/> 

select * where {
    :a (:p/:p)? ?t
} 

}
    end

    example "(pp28) Diamond, with loop -- (:p/:p)?", :status => 'unverified' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'property-path-pp28'
      expected = [
          { 
              :t => RDF::URI('http://example/a'),
          },
          { 
              :t => RDF::URI('http://example/z'),
          },
          { 
              :t => RDF::URI('http://example/c'),
          },
          { 
              :t => RDF::URI('http://example/z'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end