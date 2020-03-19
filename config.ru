$stdout.sync = true

require './covid_application.rb'

use Rack::Deflater
run CovidApplication
