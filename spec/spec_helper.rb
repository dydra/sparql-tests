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
      Dydra::Repository.create!(opts[:repository])
    rescue RestClient::UnprocessableEntity
      # already exists
    end
  end

  if importing?
    base_uri = RDF::URI(Dydra::URI) / account / opts[:repository]
    repository = Dydra::Repository.new(opts[:repository])
    log "Running dydra clear #{repository_name} #{repository}"
    repository.clear!
    opts[:graphs].each do | graph, options |
      repository_file = case
        when options[:url]
          options[:url]
        else
          tempfile = File.join(Dir.tmpdir, ('a'..'z').to_a.shuffle[0..4].join + ".#{options[:format]}")
          log "tempfile: #{tempfile}"
          File.open(tempfile, 'w+') { |f| f.write(options[:data]) }
          log IO.read(tempfile).to_s
          tempfile
      end
      context = graph == :default ? nil : graph
      log "importing data into context #{context} "
      log options[:data] || options[:url]
      repository.import!(repository_file, :context => context, :base_uri => base_uri).wait!
    end
  end

  log "Running dydra query #{repository_name} '#{opts[:query]}'"
  result = raw_result = nil
  taken = timer do
    format = case
      when opts[:form] == :construct || opts[:form] == :describe
        :parsed
      when ENV['DYDRA_XML']
        :xml
      else
        :json
    end
    raw_result = Dydra::Repository.new(account + '/' + opts[:repository]).query(opts[:query], format)
    log raw_result
    if opts[:form] == :select || opts[:form] == :ask
      result = SPARQL::Client.send("parse_#{format}_bindings".to_sym, raw_result)
      result = !!result if opts[:form] == :ask
    elsif
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

def log(what)
  puts what if debug?
end

def timer
  start = Time.now
  yield
  Time.now - start
end
