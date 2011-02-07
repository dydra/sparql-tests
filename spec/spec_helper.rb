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
  raise "No graph import method available yet" if (opts[:graphs].keys.size > 1)
  raise "Please assign a repository to upload test data to" if opts[:repository].nil?
  raise "A query is required to be run" if opts[:query].nil?

  Dydra::Client.setup!
  repository_name = "#{$dydra[:user]}/#{opts[:repository]}"

  if creating?
    log "Running dydra create #{repository_name}"
    Dydra::Repository.create!(opts[:repository])
  end

  if importing?
    repository_file = case
      when opts[:graphs][:default][:url]
        opts[:graphs][:default][:url]
      else
        repository = File.join(Dir.tmpdir, ('a'..'z').to_a.shuffle[0..4].join + ".#{opts[:graphs][:default][:format]}")
        log "tempfile: #{repository}"
        File.open(repository, 'w+') { |f| f.write(opts[:graphs][:default][:data]) }
        repository
    end
    log "importing data:"
    log opts[:graphs][:default][:data] || opts[:graphs][:default][:url]
    repository = Dydra::Repository.new(opts[:repository])
    log "Running dydra clear #{repository_name} #{repository}"
    repository.clear!
    log "Running dydra import #{repository_name} #{repository}"
    repository.import!(repository_file).wait!
  end

  log "Running dydra query #{repository_name} '#{opts[:query]}'"
  result = nil
  taken = timer do
    result = Dydra::Repository.new(opts[:repository]).query(opts[:query], :parsed)
  end
   
  log "Result: (query took #{taken} seconds)"
  log result
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
