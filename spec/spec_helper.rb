require 'bundler/setup'
require 'syspay-sdk'
require 'logger'
require 'simplecov'

SimpleCov.start

Bundler.require :default, :test

SyspaySDK::Config.load(
  File.expand_path('../config/syspay.yml', __FILE__),
  'test'
)

RSpec.configure do |config|
  include SyspaySDK::Logging

  config.filter_run focus: true

  config.run_all_when_everything_filtered = true

  SyspaySDK.logger = Logger.new(STDERR)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
