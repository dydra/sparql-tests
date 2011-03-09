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

def results_snippet_for(test)
  case test.form
    when :ask
      ask_results_snippet(test)
    when :select
      select_results_snippet(test)
    when :describe, :construct
      describe_results_snippet(test)
  end
end

def select_results_snippet(test)
  results = if File.extname(test.result.path) == '.srx'
    SPARQL::Client.parse_xml_bindings(File.read(test.result.path)).map { |result| result.to_hash }
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
  if File.extname(test.result.path) == '.srx'
    "expected = #{SPARQL::Client.parse_xml_bindings(File.read(test.result.path))}"
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

def describe_results_snippet(test)
end

def filename_for(directory, test)
  # special case dataset tests, which have an implicit graph setup that is not
  # specified in the manifests
  data_dir = case
    when test.subject =~ /dataset/
      'dataset/dataset'
    when test.action.test_data.nil?
      test.action.graphData.first.path
    else
      test.action.test_data.path
  end
  data_dir = File.basename(File.dirname(data_dir))
  filename = File.join( directory,
                        data_dir,
                        File.basename(test.subject.fragment)) 
  filename += '_spec.rb'
end

w3c_dir = ENV['DEST_DIR'] || File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec', 'sparql11',)

begin Dir.mkdir(w3c_dir) rescue nil end

tests = SPARQL::Spec.load_sparql1_0_tests

skipped = ssf_skipped = existed = count = 0
test_template = Erubis::Eruby.new(File.read(File.join(File.dirname(__FILE__), '..', 'etc', 'test.rb.erb')))
tests.each do |test|
  puts "generating for #{test.name} from #{test.manifest}"
  puts "generating for #{File.basename(File.dirname(test.action.query_file))}/#{File.basename(test.action.query_file)}"
  count += 1

  results_snippet = results_snippet_for(test)

  # dataset tests do not specify their graphs or default (and in fact default
  # is 4 files and we made this custom default.ttl)
  if test.subject =~ /dataset/
    dataset_dir = RDF::URI(File.join(File.dirname(__FILE__), '..', 'tests/data-r2/dataset'))
    test.action.test_data = dataset_dir / 'default.ttl'
    test.action.graphData = ['data-g1.ttl', 'data-g2.ttl', 'data-g3.ttl', 'data-g4.ttl'].map do |graph|
      dataset_dir / graph
    end
  end
  graphs = test.action.graphData.to_a

  filename = filename_for(w3c_dir, test)
  begin Dir.mkdir(File.dirname(filename)) rescue nil end
  query_file = test.action.query_file.path
  File.open(filename, 'w+') do |f|
    f.write test_template.result(binding)
  end
  
end

puts "skipped #{skipped} tests for not having data files, #{ssf_skipped} for not having SSF files, and there were #{count} total tests"
