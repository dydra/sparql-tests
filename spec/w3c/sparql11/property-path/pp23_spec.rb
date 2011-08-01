# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Diamond, with tail -- :p+
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/property-path/path-2-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#pp23
#
# This test is approved: 
# 
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

:z :p :X .
}
      @query = %q{
prefix : <http://example/> 

select ?z where {
    ?a :p+ ?z
} 

}
    end

    example "Diamond, with tail -- :p+", :w3c_status => 'unapproved', :status => 'bug' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'property-path-pp23'
      expected = [
          { 
              :z => RDF::URI('http://example/c'),
          },
          { 
              :z => RDF::URI('http://example/z'),
          },
          { 
              :z => RDF::URI('http://example/X'),
          },
          { 
              :z => RDF::URI('http://example/b'),
          },
          { 
              :z => RDF::URI('http://example/z'),
          },
          { 
              :z => RDF::URI('http://example/X'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
