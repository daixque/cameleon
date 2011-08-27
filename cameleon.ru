require './lib/cameleon'
use Rack::Chunked
run Cameleon::Server.new
