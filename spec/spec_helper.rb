require 'bundler'
Bundler.setup
Bundler.require(:default)
require 'rdf/cli'
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f}

# This file defines the sparql query function, which makes a sparql query and returns results.
# It respects the following environment variables, all either true or false (set or unset):
# IMPORT
#   import data files before each query (default: no)
# CREATE
#   create repositories before each query (default: no)
# DEBUG
#   enable debug output
# ACCOUNT
#   The dydra account to host data/query on.  defaults to sparql-tests.

# run a sparql query against SPOCQ.
# Options:
#   :graphs
#     example
#       opts[:graphs] ==
#        { :default => {
#             :data => '...',
#             :format => :ttl
#           },
#           <g1> => {
#            :data => '...',
#            :format => :ttl
#           }
#        }
#   :allow_empty => true
#     allow no data for query (raises an exception by default)
#   :query
#     A sparql query, as a string
#   :account
#     The dydra account hosting the queryable repository
#   :repository
#     The dydra repository associated with the account to use
#   :ssf
#     An SSF query, as a string #TODO
#   :form
#     :ask, :construct, :select or :describe
def sparql_query(opts)

  raise "Cannot run query without data" if (opts[:graphs].nil? || opts[:graphs].empty?) && !opts[:allow_empty]
  raise "Please assign a repository to upload test data to" if opts[:repository].nil?
  raise "A query is required to be run" if opts[:query].nil?

  Dydra::Client.setup!
  account = ENV['ACCOUNT'] || $dydra[:user]
  repository_name = "#{account}/#{opts[:repository]}"
  if creating?
    log "Running dydra create #{repository_name}"
    begin
      Dydra::Repository.create!(repository_name)
    rescue RestClient::UnprocessableEntity
      # already exists
    end
  end

  if importing?
    base_uri = RDF::URI(Dydra::URI) / account / opts[:repository]
    repository = Dydra::Repository.new(repository_name)
    log "Running dydra clear #{repository_name} #{repository}"
    repository.clear!.wait!
    import_repo = RDF::Repository.new
    opts[:graphs].each do | graph, options |
      next if options.nil?
      context = graph == :default ? nil : graph
      if options[:url]
        repository.import!(options[:url], :context => context, :base_uri => base_uri).wait!
        next
      end
      this_graph = RDF::Graph.new(context)
      log "importing for #{context} with format #{options[:format]}"
      reader = RDF::Format.content_types[RDF::Format.file_extensions[:ttl]].first.reader
      this_graph << reader.new(options[:data])
      import_repo << this_graph
    end
    repository.insert(*import_repo) unless import_repo.empty?
  end

  log "Running dydra query #{repository_name} '#{opts[:query]}'"
  result = raw_result = nil
  taken = timer do
    format = case opts[:form]
      when :construct, :describe, :update
        :parsed
      else
        ENV['DYDRA_XML'] ? :xml : :json
    end
    repository = Dydra::Repository.new(repository_name)
    raw_result = repository.query(opts[:query], :format => format, :user_query_id => opts[:user_id])
    log raw_result
    if (opts[:form] == :select || opts[:form] == :ask) && comparing?
      result = SPARQL::Client.send("parse_#{format}_bindings".to_sym, raw_result)
      result = !!result if opts[:form] == :ask
    elsif opts[:form] == :update
      result = repository.query('select * where { graph ?g { ?s ?p ?o } union { ?s ?p ?o }}', :format => :parsed)
    else
      result = raw_result
    end
  end
   
  log "Result: (query took #{taken} seconds)"
  log result.each_statement.to_a.map {|s| "#{s.subject} #{s.predicate} #{s.object}" }.join("\n")if result.respond_to?(:each_statement)
  result.map!(&:to_hash) if opts[:form] == :select
  result
end

def importing?
  ENV['IMPORT']
end

def debug?
  ENV['DEBUG']
end

def creating?
  ENV['CREATE']
end

def comparing?
  !ENV['NOCOMPARE']
end

def log(what)
  puts what if debug?
end

def timer
  start = Time.now
  yield
  Time.now - start
end
