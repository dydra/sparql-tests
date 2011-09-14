# coding: utf-8
#
require 'spec_helper'

# Test abbreviated aggregate forms
# 
# 

describe "unfuddle ticket" do
  context "459" do
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

select count(*)
       count (?s)
       sum(?o)
       min(?o)
       max(?o)
       avg(?o)
       sample(?p)
       group_concat(?o)
       (sum(?o) as ?sum)
where {?s ?p ?o}

}
    end

    example "abbreviated aggregation" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'dydra-459'
      expected = [
                  { :COUNT1 => RDF::Literal.new('4.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
                    :COUNT2 => RDF::Literal.new('4.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
                    :SUM3 => RDF::Literal.new('60.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
                    :MIN4 => RDF::Literal.new('10.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#float')),
                    :MAX5 => RDF::Literal.new('40.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
                    :AVG6 => RDF::Literal.new('20.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
                    :SAMPLE7 => RDF::URI.new('http://example.org/ns#number'),
                    :GROUP_CONCAT8 => RDF::Literal.new('40 10 10.0 10.0'),
                    :sum => RDF::Literal.new('60.0' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#double')),
                  }
      ]

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end


