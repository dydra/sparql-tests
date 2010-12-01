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
end

def describe_results_snippet(test)
end

dest_dir = ENV['DEST_DIR'] || File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec', 'w3c', 'data-r2')
puts "saving to #{dest_dir}"

begin Dir.mkdir(dest_dir) rescue nil end

tests = load_w3c_tests
skipped = existed = count = 0
tests.each do |test|
  count += 1
  if test.action.test_data.nil? || !File.exists?(test.action.query_file.path.sub(/\.rq/,'.ssf'))
    skipped += 1
    next
  end
  next if test.action.test_data.nil?
  filename = File.join( dest_dir,
                        File.basename(File.dirname(test.action.test_data.path)),
                        File.basename(test.subject.fragment)) 
  filename += '_spec.rb'
                        

  begin Dir.mkdir(File.dirname(filename)) rescue nil end
  results_snippet = results_snippet_for(test)
  existed += 1 if File.exists?(filename)
  template = Erubis::Eruby.new(File.read(File.join(File.dirname(__FILE__), '..', 'etc', 'test.rb.erb')))
  File.open(filename, 'w+') do |f|
    f.write template.result(binding)
  end
end

puts "skipped #{skipped} tests for not having data files, #{existed} tests appeared in manifests twice, and there were #{count} total tests"
