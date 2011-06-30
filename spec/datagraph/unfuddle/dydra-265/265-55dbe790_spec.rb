# coding: utf-8
#
require 'spec_helper'

# Test filter compilation
# 
#

describe "unfuddle ticket" do
  context "265" do
    before :all do
     @url = 'http://dydra.com/mglcel/psw.nt'
     @query = %q{
SELECT * WHERE {
 ?of1 ?pf1 <http://parisemantique.fr/entities/Way/rue_de_la_plaine> .
 ?of2 ?pf2 ?of1 .
 ?middle ?pf3 ?of2 .
 ?middle ?ps1 <http://parisemantique.fr/entities/School/ecole_elementaire_40_rue_des_pyrenees> .
 FILTER ((?pf1 != <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ) &&
         (?pf2 != <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ) &&
         (?pf3 != <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ) &&
         (?ps1 != <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> ) &&
         (!isLiteral(?middle))&&
         (?middle != <http://parisemantique.fr/entities/Way/rue_de_la_plaine> ) &&
         (?middle != <http://parisemantique.fr/entities/Way/rue_de_la_plaine> ) &&
         (?middle != <http://parisemantique.fr/entities/School/ecole_elementaire_40_rue_des_pyrenees> ) &&
(?middle != ?of1 )  &&
(?middle != ?of2 ) &&
(!isLiteral(?of1)) &&
(?of1 != <http://parisemantique.fr/entities/Way/rue_de_la_plaine> ) &&
(?of1 != <http://parisemantique.fr/entities/School/ecole_elementaire_40_rue_des_pyrenees> ) &&
(?of1 != ?middle ) &&
(?of1 != ?of2 ) &&
(!isLiteral(?of2)) &&
(?of2 != <http://parisemantique.fr/entities/Way/rue_de_la_plaine> ) &&
(?of2 != <http://parisemantique.fr/entities/School/ecole_elementaire_40_rue_des_pyrenees> ) &&
(?of2 != ?middle ) && (?of2 != ?of1 ) ).
  }
  LIMIT 10
}
    end

    example "mglcel" do
    
      graphs = {}
      graphs[:default] = { :url => @url, :format => :nt}
      repository = 'dydra-265'

      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).class.should == Array
    end
  end
end
