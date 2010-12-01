#!/usr/bin/env ruby

require_relative '../lib/sparql/models'
require 'sparql/client'
require 'erubis'

class RDF::URI
  def to_ruby
    "RDF::URI('#{self.to_s}')"
  end
end

class RDF::Literal
  def to_ruby
    "RDF::Literal.new('#{self.to_s}' #{", :datatype => #{self.datatype.to_ruby}" unless self.datatype.nil?})"
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
    SPARQL::Client.new("").parse_xml_bindings(File.read(test.result.path)).map { |result| result.to_hash }
  else
    expected_repository = RDF::Repository.new 
    Spira.add_repository!(:results, expected_repository)
    expected_repository.load(test.result.path)
    ResultBindings.each.first.solutions
  end
  template = Erubis::Eruby.new(File.read(File.join(File.dirname(__FILE__), '..', 'etc', 'bindings.rb.erb')))
  template.result(binding)
end

def ask_results_snippet(test)
  if File.extname(test.result.path) == '.srx'
    SPARQL::Client.new("").parse_xml_bindings(File.read(test.result.path))
  else
    expected_repository = RDF::Repository.new 
    Spira.add_repository!(:results, expected_repository)
    expected_repository.load(test.result.path)
    if ResultBindings.each.first.boolean.nil?
      raise "Couldn't parse ask bindings for #{test.result.path}" # just an assertion, is there another case?
    end
    "      result = #{ResultBindings.each.first.boolean}"
  end
end

def describe_results_snippet(test)
end

def filename_for(directory, test)
  filename = File.join( directory,
                        File.basename(File.dirname(test.action.test_data.path)),
                        File.basename(test.subject.fragment)) 
  filename += '_spec.rb'
end


w3c_dir = ENV['DEST_DIR'] || File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec', 'w3c', 'data-r2')
ssf_dir = ENV['DEST_DIR'] || File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec', 'ssf')

begin Dir.mkdir(w3c_dir) rescue nil end
begin Dir.mkdir(ssf_dir) rescue nil end

tests = load_w3c_tests
skipped = ssf_skipped = existed = count = 0
test_template = Erubis::Eruby.new(File.read(File.join(File.dirname(__FILE__), '..', 'etc', 'test.rb.erb')))
tests.each do |test|
  count += 1
  if test.action.test_data.nil?
    skipped += 1
    next
  end

  results_snippet = results_snippet_for(test)

  graphs = test.action.graphData.to_a

  filename = filename_for(w3c_dir, test)
  begin Dir.mkdir(File.dirname(filename)) rescue nil end
  query_file = test.action.query_file.path
  File.open(filename, 'w+') do |f|
    f.write test_template.result(binding)
  end

  filename = filename_for(ssf_dir, test)
  begin Dir.mkdir(File.dirname(filename)) rescue nil end
  query_file = test.action.query_file.path.sub(/\.rq/,'.ssf')
  if !File.exists?(test.action.query_file.path.sub(/\.rq/,'.ssf'))
    ssf_skipped += 1
    next
  end
  File.open(filename, 'w+') do |f|
    f.write test_template.result(binding)
  end
end

puts "skipped #{skipped} tests for not having data files, #{ssf_skipped} for not having SSF files, and there were #{count} total tests"
