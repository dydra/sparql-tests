require 'rdf'   # @see http://rubygems.org/gems/rdf
require 'rspec' # @see http://rubygems.org/gems/rspec

module SPARQL
  ##
  # **`SPARQL::Spec`** provides RSpec extensions for SPARQL.
  #
  # @example Requiring the `SPARQL::Spec` module
  #   require 'sparql/spec'
  #
  # @example Using the shared examples for `SPARQL::Spec::SSE`
  #   require 'sparql/spec/sse'
  #   
  #   describe SPARQL::Enumerable do
  #     before :each do
  #       @statements = RDF::NTriples::Reader.new(File.open("etc/doap.nt")).to_a
  #       @enumerable = @statements.dup.extend(RDF::Enumerable)
  #     end
  #     
  #     it_should_behave_like RDF_Enumerable
  #   end
  #
  # @example Using the shared examples for `RDF::Repository`
  #   require 'rdf/spec/repository'
  #   
  #   describe RDF::Repository do
  #     before :each do
  #       @repository = RDF::Repository.new
  #     end
  #     
  #     it_should_behave_like RDF_Repository
  #   end
  #
  # @see http://rdf.rubyforge.org/
  # @see http://rspec.info/
  #
  # @author [Arto Bendiken](http://ar.to/)
  # @author [Ben Lavender](http://bhuga.net/)
  module Spec
    autoload :Manifest,       'sparql/spec/models'
    autoload :SPARQLTest,     'sparql/spec/models'
    autoload :SPARQLAction,   'sparql/spec/models'
    autoload :SPARQLBinding,  'sparql/spec/models'
    autoload :BindingSet,     'sparql/spec/models'
    autoload :ResultBindings, 'sparql/spec/models'
    autoload :SSE,            'sparql/spec/sse'

    # Module functions
    def self.load_sparql1_0_tests
      require 'spira'
      base_directory = File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'tests')
      if ENV['MANIFEST']
        puts "Loading tests from #{ENV['MANIFEST']}"
        test_repo = RDF::Repository.new
        Spira.add_repository(:default, test_repo)
        # I'm not sure why this is correct--why not dirname?
        base_uri = ENV['MANIFEST']
        manifest_file = ENV['MANIFEST']
        test_repo.load(manifest_file, :base_uri => base_uri, :context => ENV['MANIFEST'])
        tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| t.approved? }
        tests.each { |test| test.update!(:manifest => ENV['MANIFEST']) }
      else
        cache_file = 
        if File.exists?('./sparql-specs-1_0-cache.nt')
          puts "Using cached manifests"
          Spira.add_repository(:default, RDF::Repository.load('./sparql-specs-1_0-cache.nt'))
          tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| t.approved? }
        else
          puts "building manifests..."
          test_repo = RDF::Repository.new
          Spira.add_repository(:default, test_repo)
          test_repo.load("#{base_directory}/data-r2/manifest-evaluation.ttl", :base_uri => "#{base_directory}/data-r2/")
          Manifest.each do |manifest| manifest.include_files! end
          tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| !t.result.nil? }
          tests.each { |test|
            test.tags << 'status:unverified'
            test.tags << 'w3c_status:unapproved' unless test.approved?
            test.update!(:manifest => test.data.each_context.first)
          }
          File.open('./sparql-specs-1_0-cache.nt', 'w+') do |file|
            file.write RDF::Writer.for(:ntriples).dump(Spira.repository(:default))
          end
        end
      end
      tests
    end

    def self.load_sparql1_1_tests
      require 'spira'
      base_directory = File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'tests')
      if ENV['MANIFEST']
        puts "Loading tests from #{ENV['MANIFEST']}"
        test_repo = RDF::Repository.new
        Spira.add_repository(:default, test_repo)
        # I'm not sure why this is correct--why not dirname?
        base_uri = ENV['MANIFEST']
        manifest_file = ENV['MANIFEST']
        test_repo.load(manifest_file, :base_uri => base_uri, :context => ENV['MANIFEST'])
        tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| t.approved? }
        tests.each { |test| test.update!(:manifest => ENV['MANIFEST']) }
      else
        if File.exists?('./sparql-specs-cache.nt')
          puts "Using cached manifests"
          Spira.add_repository(:default, RDF::Repository.load('./sparql-specs-cache.nt'))
          tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| t.approved? }
        else
          puts "building manifests..."
          test_repo = RDF::Repository.new
          Spira.add_repository(:default, test_repo)
          test_repo.load("#{base_directory}/sparql11-tests/data-sparql11/manifest-all.ttl", :base_uri => "#{base_directory}/sparql11-tests/data-sparql11/")
          Manifest.each do |manifest| manifest.include_files! end
          tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| !t.result.nil? }
          tests.each { |test|
            test.tags << 'status:unverified'
            test.tags << 'w3c_status:unapproved' unless test.approved?
            test.update!(:manifest => test.data.each_context.first)
          }
          File.open('./sparql-specs-cache.nt', 'w+') do |file|
            file.write RDF::Writer.for(:ntriples).dump(Spira.repository(:default))
          end
        end
      end
      tests
    end
  end # Spec
end # RDF
