# coding: utf-8
#
require 'spec_helper'
repository = ENV['REPOSITORY'] || 'sp2b-50k'

# SP2B Query 11 50k triples
# 
describe "SP2B" do
  context "query 11" do
    before :all do
      @url = 'http://public.datagraph.org.s3.amazonaws.com/' + repository + '.nt'
      
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

    example "for #{repository}" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :ttl}
      expected_length = 10
      expected = [
                  {
                    :ee => RDF::Literal.new('http://www.advocator.tld/contuses/fricassees.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.aerates.tld/enhancement/junkmen.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.aerophobia.tld/reimbursement/spinout.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affecter.tld/asap/succored.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affecters.tld/incarnated/participates.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.afferently.tld/retries/jogs.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affinities.tld/trephining/reevaluates.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affirmativeness.tld/pistils/postmasters.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.affirming.tld/gravelly/bovinely.html'),
                  },
                  {
                    :ee => RDF::Literal.new('http://www.afforests.tld/sculptured/photosynthesizing.html'),
                  },
                 ]

      result = sparql_query(:user_id => "sp2b.q11.#{repository[5..-1]}",
                            :graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                            :repository => repository, :form => :select)
      result.length.should == expected_length
      if ( repository == "sp2b-50k" )
        result.should =~ expected
      end
    end
  end
end
