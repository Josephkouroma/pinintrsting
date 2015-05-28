# This file is used by Rack-based servers to start the application.
#!/usr/bin/env ruby
# require 'thin'
# require 'rack'
# # require 'active_support/dependencies'
# require 'action_controller'

require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application
