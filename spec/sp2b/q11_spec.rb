# coding: utf-8
#
require 'spec_helper'

# SP2B Query 11 50k triples
# 
describe "SP2B" do
  context "query 11" do
    before :all do
      @repository = ENV['REPOSITORY'] || 'sp2b-50k'
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + @repository + '.nt'
      
      @query = %q(
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?ee
WHERE {
  ?publication rdfs:seeAlso ?ee
}
ORDER BY ?ee
LIMIT 10
OFFSET 50
)
    end

    example "sp2b-q11-50k" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}


      expected = [
                  {
                    :ee => RDF::Literal.new('http://www.advertisement.tld/ordainer/drabbed.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.advised.tld/eyetooth/underseas.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.advocator.tld/contuses/fricassees.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.aerates.tld/enhancement/junkmen.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.aerophobia.tld/reimbursement/spinout.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affecter.tld/asap/succored.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affecters.tld/incarnated/participates.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.afferently.tld/retries/jogs.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affinities.tld/trephining/reevaluates.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affirmativeness.tld/pistils/postmasters.html', :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
                  },
                 ]

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => @repository, :form => :select).should =~ expected
    end
  end
end
