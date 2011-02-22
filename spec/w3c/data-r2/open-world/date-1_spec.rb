# coding: utf-8
#
require 'spec_helper'

#
# date-1
# Added type : xsd:date '!='
# /Users/ben/repos/datagraph/tests/tests/data-r2/open-world/date-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#date-1
#
#
describe "W3C test" do
  context "open-world" do
    before :all do
      @data = %q{
@prefix     : <http://example/> .
@prefix  xsd:    <http://www.w3.org/2001/XMLSchema#> .

:dt1 :r "2006-08-23T09:00:00+01:00"^^xsd:dateTime .

:d1 :r "2006-08-23"^^xsd:date .
:d2 :r "2006-08-23Z"^^xsd:date .
:d3 :r "2006-08-23+00:00"^^xsd:date .

:d4 :r "2001-01-01"^^xsd:date .
:d5 :r "2001-01-01Z"^^xsd:date .

:d6 :s "2006-08-23"^^xsd:date .
:d7 :s "2006-08-24Z"^^xsd:date .
:d8 :s "2000-01-01"^^xsd:date .

}
      @query = %q{
PREFIX     :    <http://example/>
PREFIX  xsd:    <http://www.w3.org/2001/XMLSchema#>

SELECT *
{
    ?x :r ?v .
    FILTER ( ?v = "2006-08-23"^^xsd:date )
}
}
    end

    example "date-1", :tz => 'zoned' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'open-world-date-1'
      expected = [
          { 
              :v => RDF::Literal.new('2006-08-23' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#date')),
              :x => RDF::URI('http://example/d1'),
          }
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
