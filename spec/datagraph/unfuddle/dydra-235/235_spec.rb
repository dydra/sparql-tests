# coding: utf-8
#
require 'spec_helper'

# Test handling standard and non-standard escapes
# 
#

describe "unfuddle ticket" do
  context "235" do
    before :all do
     @url = 'http://rdf.dydra.com/barbz/scuole.nt'
     @query = %q{

PREFIX gn:<http://www.geonames.org/ontology#>
PREFIX rdfs:<http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX edu:<http://purl.org/net7/vocab/scuole/v1#>
PREFIX vcard:<http://www.w3.org/2006/vcard/ns#>
SELECT DISTINCT ?url ?codiceMecc ?scuola_name ?tipoIIgrado ?indstudio ?comune_l
WHERE {
 ?url edu:tipoDiScuola <http://data.linkedopendata.it/scuole/resource/scuola_secondaria_di_II_grado>.
 ?url edu:tipoDiScuolaIIGrado ?tipoIIgrado .
 ?tipoIIgrado rdfs:label ?tipoIIgrado_l .
 ?url rdfs:label ?scuola_name.
 ?url edu:codiceMeccanografico ?codiceMecc .
 ?url vcard:adr ?sede.
 ?sede vcard:locality ?comune.
 ?comune rdfs:label ?comune_l.
 ?comune gn:parentADM2 ?provincia. 
 ?provincia rdfs:label "Ancona".
 ?url edu:indirizziStudio ?indstudio.
 FILTER regex (str(?indstudio), "GIURIDICO ECONOMICO AZIENDALE")
}

}
    end

    example "barbz/scuole" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :nt}


      repository = 'unfuddle-235'
      expected_length = 8

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
