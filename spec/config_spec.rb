require 'spec_helper'

describe Syspay::SDK::Config do
  Config = Syspay::SDK::Config

  it "loads configuration file and default environment" do
    lambda do
      Config.load("spec/config/syspay.yml", "test")
      Config.default_environment.should eq("test")
    end.should_not raise_error
  end

  it "sets default environment" do
    begin
      backup_default_environment = Config.default_environment
      Config.default_environment = "new_env"
      Config.default_environment.should eq("new_env")
    ensure
      Config.default_environment = backup_default_environment
    end
  end

  it "sets configuration values" do
    begin
      backup_configurations = Config.configurations
      Config.configurations = { Config.default_environment => { :syspay_id => "direct", :syspay_passphrase => "direct" } }
      Config.config.syspay_id.should eq("direct")
      Config.config.syspay_passphrase.should eq("direct")
    ensure
      Config.configurations = backup_configurations
    end
  end

  it "configures using parameters" do
    begin
      backup_configurations = Config.configurations
      Config.configurations = nil
      Config.configure( :syspay_id => "Testing" )
      Config.config.syspay_id.should eq("Testing")
    ensure
      Config.configurations = backup_configurations
    end
  end

  it "configures with block" do
    begin
      backup_configurations = Config.configurations
      Config.configurations = nil
      Config.configure do |config|
        config.syspay_id = "Testing"
      end
      Config.config.syspay_id.should eq("Testing")
    ensure
      Config.configurations = backup_configurations
    end
  end

  it "configure with default values" do
    begin
      backup_configurations = Config.configurations
      default_config = Config.config
      Config.configure do |config|
        config.syspay_id = "Testing"
      end
      Config.config.syspay_id.should eq("Testing")
      Config.config.syspay_mode.should_not be_nil
      Config.config.syspay_mode.should eq(default_config.syspay_mode)
    ensure
      Config.configurations = backup_configurations
    end
  end

  it "validates configuration" do
    config = Config.new( :syspay_id => "XYZ")
    lambda { config.required!(:syspay_id) }.should_not raise_error
    lambda { config.required!(:syspay_passphrase) }.should raise_error "Required configuration(syspay_passphrase)"
    lambda { config.required!(:syspay_id, :syspay_passphrase) }.should raise_error "Required configuration(syspay_passphrase)"
    lambda { config.required!(:syspay_passphrase, :syspay_mode) }.should raise_error "Required configuration(syspay_passphrase, syspay_mode)"
  end

  it "returns default environment configuration" do
    Config.config.should be_a(Config)
  end

  it "returns configuration based on environment" do
    Config.config(:development).should be_a(Config)
  end

  it "overrides default configuration" do
    override_configuration = { :syspay_id => "test.example.com", :syspay_mode => "test"}
    config = Config.config(override_configuration)

    config.syspay_id.should eq(override_configuration[:syspay_id])
    config.syspay_mode.should eq(override_configuration[:syspay_mode])
  end

  it "gets cached config" do
    Config.config(:test).should eq(Config.config(:test))
    Config.config(:test).should_not eq(Config.config(:development))
  end

  it "raises an error on invalid environment" do
    lambda { Config.config(:invalid_env) }.should raise_error "Configuration[invalid_env] NotFound"
  end

  it "sets logger" do
    require 'logger'
    my_logger = Logger.new(STDERR)
    Config.logger = my_logger
    Config.logger.should eq(my_logger)
  end

  it "has access to Syspay::SDK methods" do
    Syspay::SDK.configure.should eq(Syspay::SDK::Config.config)
    Syspay::SDK.logger.should eq(Syspay::SDK::Config.logger)
    Syspay::SDK.logger = Syspay::SDK.logger
    Syspay::SDK.logger.should eq(Syspay::SDK::Config.logger)
  end

  describe "::Configuration" do
    class TestConfig
      include Syspay::SDK::Configuration
    end

    it "gets default configuration" do
      test_object = TestConfig.new
      test_object.config.should be_a(Config)
    end

    it "changes environment" do
      test_object = TestConfig.new
      test_object.set_config("test")
      test_object.config.should eq(Config.config("test"))
      test_object.config.should_not eq(Config.config("development"))
    end

    it "overrides environment configuration" do
      test_object = TestConfig.new
      test_object.set_config("test", :syspay_id => "test")
      test_object.config.should_not eq(Config.config("test"))
    end

    it "overrides default/current configuration" do
      test_object = TestConfig.new
      test_object.set_config( :syspay_id => "test")
      test_object.set_config( :syspay_passphrase => "test")
      test_object.config.syspay_passphrase.should eq("test")
      test_object.config.syspay_id.should eq("test")
    end

    it "appends ssl_options" do
      test_object = TestConfig.new
      test_object.set_config( :ssl_options => { :ca_file => "test_path" } )
      test_object.config.ssl_options[:ca_file].should eql "test_path"
      test_object.set_config( :ssl_options => { :verify_mode => 1 } )
      test_object.config.ssl_options[:verify_mode].should eql 1
      test_object.config.ssl_options[:ca_file].should eql "test_path"
    end

    it "sets configuration without loading configuration File" do
      backup_configurations = Config.configurations
      begin
        Config.configurations = nil
        test_object = TestConfig.new
        lambda { test_object.config }.should raise_error
        test_object.set_config( :syspay_id => "test" )
        test_object.config.should be_a(Config)
      ensure
        Config.configurations = backup_configurations
      end
    end
  end
end