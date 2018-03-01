require 'bundler/setup'
require 'syspay_sdk'
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

  SyspaySDK.logger = Logger.new(STDERR)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
