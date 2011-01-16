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
#   The datagraph account to host data/query on.  defaults to jhacker.

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
#     The datagraph account hosting the queryable repository
#   :repository
#     The datagraph repository associated with the account to use
#   :ssf
#     An SSF query, as a string #TODO
#   :form
#     :ask, :construct, :select or :describe
def sparql_query(opts)

  raise "Cannot run query without data" if (opts[:graphs].nil? || opts[:graphs].empty?) && !opts[:allow_empty]
  raise "No graph import method available yet" if (opts[:graphs].keys.size > 1)
  raise "Please assign a repository to upload test data to" if opts[:repository].nil?
  raise "A query is required to be run" if opts[:query].nil?

  account = ENV['ACCOUNT'] || opts[:account] || 'jhacker'

  repository_name = "#{account}/#{opts[:repository]}"

  # should work:
  # Dydra.authenticate('jhacker','jhackers password')

  if creating?
    # should be:
    # Dydra::Repository.create(opts[:repository])
    log "Running datagraph create #{repository_name}"
    Dydra::Command::Create.new.execute(repository_name)
  end

  if importing?
    # whole thing should be:
    # Dydra::Repository.new(opts[:repository]).import(repository)
    # should figure out if loading a URL, file, or string containing RDF, or an RDF::Enumerable
    repository = case
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
    log "Running datagraph import #{repository_name} #{repository}"
    Dydra::Command::Import.new.execute(repository_name, repository)
  end

  # should be:
  # result = Dydra::Repository.query(opts[:repository], opts[:query])
  # should figure out if query is a file or a string without the leading @
  log "Running datagraph query #{repository_name} '#{opts[:query]}'"
  result = capture_stdout do
    Dydra::Command::Query.new.execute(repository_name, opts[:query])
  end.string
  log "Raw results:"
  log result
 
  # result should already be parsed, much like below.
  result = case opts[:form]
    when :ask
      case result.strip
        when 'true'
          true
        when 'false'
          false
        else
          raise "Got something other than true or false for an ask query: '#{result}'"
      end
    when :select
      SPARQL::Client.new("").parse_json_bindings(result).map { | result | result.to_hash }
    when :describe
      # TODO
    when :construct
      # TODO
  end

  log "parsed results:"
  log result

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

def capture_stdout
  out = StringIO.new
  $stdout = out
  yield
  return out
ensure
  $stdout = STDOUT
end

