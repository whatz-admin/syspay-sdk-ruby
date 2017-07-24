require 'bundler/setup'
require 'syspay-sdk'
require 'logger'

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start do
    add_filter "/spec/"
  end
end

Bundler.require :default, :test

SyspaySDK::Config.load(File.expand_path('../config/syspay.yml', __FILE__), 'test')

include SyspaySDK::Logging

SyspaySDK.logger = Logger.new(STDERR)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end