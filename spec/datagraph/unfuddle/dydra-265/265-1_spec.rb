# coding: utf-8
#
require 'spec_helper'

# Test handling standard and non-standard escapes
# 
#

describe "unfuddle ticket" do
  context "265" do
    before :all do
     @url = 'http://rdf.staging.dydra.com/ben/psw.ttl'
     @query = %q{
SELECT * WHERE {
 <http://parisemantique.fr/entities/InsalubrityOrder/250> ?pf1 ?middle .
 <http://parisemantique.fr/entities/Quarter/clignancourt> ?ps1 ?middle .
 FILTER ((?pf1 != <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ) &&
         (?ps1 != <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ) &&
         (!isLiteral(?middle)) && (?middle != <http://parisemantique.fr/entities/InsalubrityOrder/250> ) && (?middle != <http://parisemantique.fr/entities/Quarter/clignancourt> ) ). } LIMIT 10
}
    end

    example "mglcel" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :nt}


      repository = 'dydra-265'
      expected_length = 8

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).length.should == expected_length
    end
  end
end
