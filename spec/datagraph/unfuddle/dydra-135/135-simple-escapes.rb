# coding: utf-8
#
require 'spec_helper'

# Test handling standard and non-standard escapes
# 


describe "unfuddle ticket" do
  context "135" do
    before :all do
      @data = %q{
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .

<http://example/v0> <http://planetrdf.com/ns/content> ""^^xsd:string .
<http://example/v1> <http://planetrdf.com/ns/content> "abc"^^xsd:string .
<http://example/v2> <http://planetrdf.com/ns/content> "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"^^xsd:string .
<http://example/v3> <http://planetrdf.com/ns/content> "\\u0001\\uFFFF"^^xsd:string .
# fails for \U0100FFF
# <http://example/v3> <http://planetrdf.com/ns/content> "\\u0001\\uFFFF\\U0100FFFF"^^xsd:string .
# still to do
# <http://example/v2> <http://planetrdf.com/ns/content> "\\t\\u0008\\n\\r\\u000C !\\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\\\]^_`abcdefghijklmnopqrstuvwxyz{|}~" .
}
      @query = %q{
PREFIX :    <http://planetrdf.com/ns/>

SELECT ?s ?o
WHERE { ?s :content ?o }
}
    end

    example "simple escapes" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = '135-simple-escapes'
      expected = [
          {
              :s => RDF::URI('http://example/v0'),
              :o => RDF::Literal.new('', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          {
              :s => RDF::URI('http://example/v1'),
              :o => RDF::Literal.new('abc', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              :s => RDF::URI('http://example/v2'),
              :o => RDF::Literal.new('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              :s => RDF::URI('http://example/v3'),
              :o => RDF::Literal.new("\u0001\uFFFF", :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
#              :o => RDF::Literal.new("\u0001\uFFFF\U0100FFFF", :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
#          { 
#              :s => RDF::URI('http://example/v2'),
#              :o => RDF::Literal.new('\\t\\b\\n\\r\\f !\\"#$%&\\\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\\\]^_`abcdefghijklmnopqrstuvwxyz{|}~', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
#          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
