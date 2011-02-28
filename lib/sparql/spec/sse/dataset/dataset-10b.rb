# coding: utf-8
#
require 'spec_helper'

# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/data-r2/dataset/dawg-dataset-10b
describe "W3C test" do
  context "dataset" do
    before :all do
      @query = %q{
        (prefix ((: <http://example/>))
          (dataset (<data-g3-dup.ttl> (named <data-g3.ttl>))
            (join
              (bgp (triple ?s ?p ?o))
              (graph ?g
                (bgp (triple ?s ?q ?v))))))
      }
    end

    example "dawg-dataset-10b" do
    
      graphs = {}

      repository = 'dawg-dataset-10b'
      expected = [
          {
          },
      ]

      sparql_query(:graphs => graphs, :query => @query, :base_uri => File.expand_path(__FILE__),
                   :repository => repository, :form => :select).should =~ expected

    end
  end
end
