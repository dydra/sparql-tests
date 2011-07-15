#!/usr/bin/env ruby

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'sparql/spec'
require 'sparql/spec/models'
require 'sparql/client'
require 'erubis'

class RDF::URI
  def to_ruby
    "RDF::URI('#{self.to_s}')"
  end
end

class RDF::Literal
  def to_ruby
    "RDF::Literal.new('#{self.to_s}' #{", :datatype => #{self.datatype.to_ruby}" unless self.datatype.nil?}#{", :language => '#{self.language.to_s}'" if self.has_language?})"
  end
end

class RDF::Node
  def to_ruby
    "RDF::Node.new('#{self.id}')"
  end
end

class RDF::Statement
  def to_ruby
    "[#{subject.to_ruby}, #{predicate.to_ruby}, #{object.to_ruby}#{context ? ", #{context.to_ruby}" : ''}]"
  end
end

def results_snippet_for(test)
  case test.form
    when :ask
      ask_results_snippet(test)
    when :select
      select_results_snippet(test)
    when :describe, :construct
      describe_results_snippet(test)
    when :update
      update_results_snippet(test)
    else
      raise NotImplementedError
  end
end

def parse_method_for(extension)
  case extension
    when 'srx'
      :parse_xml_bindings
    when 'srj'
      :parse_json_bindings
    end
end

def select_results_snippet(test)
  results = if File.extname(test.result.path) =~ /\.(srx|srj)/
    method = parse_method_for($1)
    SPARQL::Client.__send__(method, File.read(test.result.path)).map { |result| result.to_hash }
  else
    expected_repository = RDF::Repository.new 
    Spira.add_repository!(:results, expected_repository)
    expected_repository.load(test.result.path)
    SPARQL::Spec::ResultBindings.each.first.solutions
  end
  template = Erubis::Eruby.new(File.read(File.join(File.dirname(__FILE__), '..', 'etc', 'bindings.rb.erb')))
  template.result(binding)
end

def ask_results_snippet(test)
  if File.extname(test.result.path) =~ /\.(srx|srj)/
    method = parse_method_for($1)
    "      expected = #{SPARQL::Client.__send__(method, File.read(test.result.path))}"
  else
    expected_repository = RDF::Repository.new 
    Spira.add_repository!(:results, expected_repository)
    expected_repository.load(test.result.path)
    if SPARQL::Spec::ResultBindings.each.first.boolean.nil?
      raise "Couldn't parse ask bindings for #{test.result.path}" # just an assertion, is there another case?
    end
    "      expected = #{SPARQL::Spec::ResultBindings.each.first.boolean}"
  end
end

def update_results_snippet(test)
  expected_repo = RDF::Repository.new
  puts "result file: #{test.result.data_file}"
  expected_repo.load(test.result.data_file.to_s) unless test.result.data_file.nil?
  test.result.graphData.each do |graph|
    expected_repo.load(graph.data_file.to_s)
  end
  template = Erubis::Eruby.new(File.read(File.join(File.dirname(__FILE__), '..', 'etc', 'graph-results.rb.erb')))
  template.result(binding)
end

def describe_results_snippet(test)
end

def filename_for(directory, test)
  # special case dataset tests, which have an implicit graph setup that is not
  # specified in the manifests
  data_dir = test.action.query_file.path
  data_dir = File.basename(File.dirname(data_dir))
  filename = File.join( directory,
                        data_dir,
                        File.basename(test.subject.fragment)) 
  filename += '_spec.rb'
end

w3c_dir = ENV['DEST_DIR'] || File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec', 'sparql11',)

begin Dir.mkdir(w3c_dir) rescue nil end

tests = SPARQL::Spec.load_sparql1_1_tests

skipped = ssf_skipped = existed = count = 0
tests.each do |test|
  puts "generating for #{test.name} from #{test.manifest}"
  puts "generating for #{File.basename(File.dirname(test.action.query_file))}/#{File.basename(test.action.query_file)}"
  count += 1
  
  test_template = Erubis::Eruby.new(File.read(File.join(File.dirname(__FILE__), '..', 'etc', test.template_file)))

  results_snippet = results_snippet_for(test)

  graphs = test.action.graphData.to_a

  filename = filename_for(w3c_dir, test)
  begin Dir.mkdir(File.dirname(filename)) rescue nil end
  query_file = test.action.query_file.path
  File.open(filename, 'w+') do |f|
    f.write test_template.result(binding)
  end
  
end

puts "skipped #{skipped} tests for not having data files, #{ssf_skipped} for not having SSF files, and there were #{count} total tests"
