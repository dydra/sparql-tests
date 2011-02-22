# Require all SSE specs
Dir.glob(File.join(File.expand_path(File.dirname(__FILE__)), 'sse', '**', '*.rb')).each {|f| require f}
