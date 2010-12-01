require 'rdf'
require 'spira'
require 'rdf/raptor'
require 'rdf/isomorphic'

DAWG = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-dawg#')
MF = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#')
QT = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-query#')
RS = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/result-set#')

class Manifest < Spira::Base
  type MF.Manifest
  has_many :manifests,  :predicate => MF.include
  property :entry_list, :predicate => MF.entries
  property :comment,    :predicate => RDFS.comment

  def entries
    RDF::List.new(entry_list, self.class.repository).map { |entry| entry.as(SPARQLTest) }
  end

  def include_files!
    manifests.each do |manifest|
      RDF::List.new(manifest, self.class.repository).each do |file|
        self.class.repository.load(file.path, :context => file.path)
      end
    end
  end
end

class SPARQLTest < Spira::Base
  property :name, :predicate => MF.name
  property :comment, :predicate => RDFS.comment
  property :action, :predicate => MF.action, :type => 'SPARQLAction'
  property :result, :predicate => MF.result
  property :approval, :predicate => DAWG.approval
  property :approved_by, :predicate => DAWG.approvedBy
  property :manifest, :predicate => MF.manifest_file

  def approved?
    approval == DAWG.Approved
  end

  def form
    query_data = IO.read(action.query_file.path)
    if query_data =~ /(ASK|CONSTRUCT|DESCRIBE|SELECT)/i
      case $1.upcase
        when 'ASK'
          :ask
        when 'SELECT'
          :select
        when 'DESCRIBE'
          :describe
        when 'CONSTRUCT'
          :construct
      end
    else
      raise "Couldn't determine query type for #{test.name} (reading #{query_data})"
    end
  end
end

class SPARQLAction < Spira::Base
  property :query_file, :predicate => QT.query
  property :test_data,  :predicate => QT.data
  has_many :graphData, :predicate => QT.graphData

  def query_string
    IO.read(query_file.path)
  end
end

class SPARQLBinding < Spira::Base
  property :value,    :predicate => RS.value, :type => Native
  property :variable, :predicate => RS.variable
  default_source :results
end

class BindingSet < Spira::Base
  default_source :results
  has_many :bindings, :predicate => RS.binding, :type => 'SPARQLBinding'
  property :index,    :predicate => RS.index, :type => Integer
end

class ResultBindings < Spira::Base
  type RS.ResultSet
  has_many :variables, :predicate => RS.ResultSet
  has_many :solution_lists, :predicate => RS.solution, :type => 'BindingSet'
  property :boolean, :predicate => RS.boolean, :type => Boolean # for ask queries
  default_source :results

  def solutions
    @solutions ||= solution_lists.map { |solution_list|
      solution_list.bindings.inject({}) { |hash, binding|
        hash[binding.variable] = binding.value
        hash
      }
    }
  end

  def self.for_solutions(solutions, opts = {})
    opts[:uri] ||= RDF::Node.new
    index = 1 if opts[:index]
    result_bindings = self.for(opts[:uri]) do | binding_graph |
      solutions.each do | result_hash | 
        binding_graph.solution_lists << BindingSet.new do | binding_set |
          result_hash.to_hash.each_pair do |hash_variable, hash_value|
            binding_set.bindings << SPARQLBinding.new do | sparql_binding |
              sparql_binding.variable = hash_variable.to_s
              sparql_binding.value = hash_value.respond_to?(:canonicalize) ? hash_value.dup.canonicalize : hash_value
            end
          end
          if opts[:index]
            binding_set.index = index
            index += 1
          end
        end
      end
    end
  end

  def self.pretty_print
    self.each do |result_binding|
    log "Result Bindings #{result_binding.subject}"
      result_binding.solution_lists.each.sort { |bs, other| bs.index.respond_to?(:'<=>') ? bs.index <=>  other.index : 0 }.each do |binding_set|
         log "  Solution #{binding_set.subject} (# #{binding_set.index})"
         binding_set.bindings.sort { |b, other| b.variable.to_s <=> other.variable.to_s }.each do |binding|
           log "    #{binding.variable}: #{binding.value.inspect}"
         end
      end
    end
  end

end

def load_w3c_tests
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
      test_repo.load("#{base_directory}/data-r2/manifest-evaluation.ttl", :base_uri => "#{base_directory}/data-r2/")
      test_repo.load("#{base_directory}/data-r2/extended-manifest-evaluation.ttl", :base_uri => "#{base_directory}/data-r2/")
      Manifest.each do |manifest| manifest.include_files! end
      tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| t.approved? }
      tests.each { |test| test.update!(:manifest => test.data.each_context.first) }
      File.open('./sparql-specs-cache.nt', 'w+') do |file|
        file.write RDF::Writer.for(:ntriples).dump(Spira.repository(:default))
      end
    end
  end
  tests
end

