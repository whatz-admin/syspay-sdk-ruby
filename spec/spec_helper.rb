require 'bundler/setup'

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start do
    add_filter "/spec/"
  end
end

Bundler.require :default, :test
Syspay::SDK::Config.load(File.expand_path('../config/syspay.yml', __FILE__), 'test')

require 'syspay-sdk'

include Syspay::SDK::Logging

require 'logger'

Syspay::SDK.logger = Logger.new(STDERR)

# Set logger for http
# http_log = File.open(File.expand_path('../log/http.log', __FILE__), "w")
# Payment.api.http.set_debug_output(http_log)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :should
  end
end