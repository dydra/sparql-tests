
require 'bundler'
Bundler.setup
Bundler.require(:default)
require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new('csv') do |t|
    file = File.dirname(__FILE__) + '/spec/support/formatters/csv_formatter.rb'
    t.rspec_opts = []
    t.rspec_opts  << ['--require', file]
    t.rspec_opts << ['--format', 'CSVFormatter']
    t.rspec_opts << ['--tag', '~values:lexical']
    t.rspec_opts << ['--tag', '~arithmetic:boxed']
    t.rspec_opts << ['--tag', '~blank_nodes:unique']
    t.rspec_opts << ['--tag', '~reduced:all']
    t.rspec_opts << ['--tag', '~status:bug']
    t.rspec_opts << ['--tag', '~tz:zoned']
    t.pattern = 'spec/w3c/data-r2/**/*.rb'
    t.verbose = false
  end
end

