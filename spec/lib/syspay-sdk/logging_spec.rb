require 'spec_helper'
require 'stringio'

describe SyspaySDK::Logging do
  Logging = described_class

  class TestLogging
    include Logging
  end

  before :each do
    @logger_file   = StringIO.new
    Logging.logger = Logger.new(@logger_file)
    @test_logging = TestLogging.new
  end

  it 'get logger object' do
    expect(@test_logging.logger).to be_a(Logger)
  end

  it 'write message to logger' do
    test_message = 'Example log message!!!'
    @test_logging.logger.info(test_message)
    @logger_file.rewind

    expect(@logger_file.read).to match(test_message)
  end

  it 'is properly formatted' do
    test_message = 'Example log message!!!'
    @test_logging.log_event(test_message) {}
    @logger_file.rewind

    expect(@logger_file.read).to match(test_message)
  end
end
