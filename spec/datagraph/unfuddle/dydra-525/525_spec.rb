# coding: utf-8
#
require 'spec_helper'

# Test handling standard and non-standard escapes
# 
#

describe "unfuddle ticket" do
  context "525" do
    before :all do
      @loadQuery = %q{
LOAD <http://rdf.rubyforge.org/doap.ttl>
}
      @countQuery = %q{
SELECT (count(*) as ?count) where {?s ?p ?o}
}
      @loadQueryNamed = %q{
LOAD <http://rdf.rubyforge.org/doap.ttl> INTO GRAPH <http://example.org/>
}
      @countQueryNamed = %q{
SELECT (count(*) as ?count) 
FROM NAMED <http://example.org/>
WHERE {GRAPH ?g  {?s ?p ?o} }
}
    end

    example "load" do
    
      graphs = {}
      graphs[:default] = nil


      repository = 'unfuddle-525'
      expected = [
                  {
                    :count => RDF::Literal.new('73.0', :datatype=> RDF::URI('http://www.w3.org/2001/XMLSchema#decimal'))
                  },
                 ]

      sparql_query(:graphs => graphs, :query => @loadQuery, :repository => repository, :form => :update)
      sparql_query(:graphs => graphs, :query => @countQuery, :repository => repository, :form => :select).should == expected

      sparql_query(:graphs => graphs, :query => @loadQueryNamed, :repository => repository, :form => :update)
      sparql_query(:graphs => graphs, :query => @countQueryNamed, :repository => repository, :form => :select).should == expected
    end
  end
end
