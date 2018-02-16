require 'spec_helper'

describe SyspaySDK::Config do
  it "loads configuration file and default environment" do
    expect {
      described_class.load("spec/config/syspay.yml", "test")
      expect(described_class.default_environment).to eq("test")
    }.not_to raise_error
  end

  before :each do
    @backup_default_environment = described_class.default_environment
    @backup_configurations = described_class.configurations
  end

  after :each do
    described_class.default_environment = @backup_default_environment
    described_class.configurations = @backup_configurations
  end

  it "sets default environment" do
    described_class.default_environment = "new_env"

    expect(described_class.default_environment).to eq("new_env")
  end

  it "sets configuration values" do
    described_class.configurations = { described_class.default_environment => { :syspay_id => "direct", :syspay_passphrase => "direct" } }

    expect(described_class.config.syspay_id).to eq("direct")
    expect(described_class.config.syspay_passphrase).to eq("direct")
  end

  it "configures using parameters" do
    described_class.configurations = nil
    described_class.configure( :syspay_id => "Testing" )

    expect(described_class.config.syspay_id).to eq("Testing")
  end

  it "configures with block" do
    described_class.configurations = nil
    described_class.configure do |config|
      config.syspay_id = "Testing"
    end

    expect(described_class.config.syspay_id).to eq("Testing")
  end

  it "configure with default values" do
    default_config = described_class.config

    described_class.configure do |config|
      config.syspay_id = "Testing"
    end

    expect(described_class.config.syspay_id).to eq("Testing")
    expect(described_class.config.syspay_mode).to_not be_nil
    expect(described_class.config.syspay_mode).to eq(default_config.syspay_mode)
  end

  it "validates configuration" do
    config = described_class.new( :syspay_id => "XYZ")

    expect {
      config.required!(:syspay_id)
    }.to_not raise_error

    expect {
      config.required!(:syspay_passphrase)
    }.to raise_error "Required configuration(syspay_passphrase)"

    expect {
      config.required!(:syspay_id, :syspay_passphrase)
    }.to raise_error "Required configuration(syspay_passphrase)"

    expect {
      config.required!(:syspay_passphrase, :syspay_mode)
    }.to raise_error "Required configuration(syspay_passphrase, syspay_mode)"
  end

  it "returns default environment configuration" do
    expect(described_class.config).to be_a(described_class)
  end

  it "returns configuration based on environment" do
    expect(described_class.config(:development)).to be_a(described_class)
  end

  it "overrides default configuration" do
    override_configuration = { :syspay_id => "test.example.com", :syspay_mode => "test"}
    config = described_class.config(override_configuration)

    expect(config.syspay_id).to eq(override_configuration[:syspay_id])
    expect(config.syspay_mode).to eq(override_configuration[:syspay_mode])
  end

  it "gets cached config" do
    expect(described_class.config(:test)).to eq(described_class.config(:test))
    expect(described_class.config(:test)).to_not eq(described_class.config(:development))
  end

  it "raises an error on invalid environment" do
    expect { described_class.config(:invalid_env) }.to raise_error "Configuration[invalid_env] NotFound"
  end

  it "sets logger" do
    require 'logger'
    my_logger = Logger.new(STDERR)

    described_class.logger = my_logger
    expect(described_class.logger).to eq(my_logger)
  end

  it "has access to SyspaySDK methods" do
    expect(SyspaySDK.configure).to eq(SyspaySDK::Config.config)
    expect(SyspaySDK.logger).to eq(SyspaySDK::Config.logger)

    SyspaySDK.logger = SyspaySDK.logger

    expect(SyspaySDK.logger).to eq(SyspaySDK::Config.logger)
  end

  describe "::Configuration" do
    class TestConfig
      include SyspaySDK::Configuration
    end

    subject { TestConfig.new }

    it "gets default configuration" do
      expect(subject.config).to be_a(described_class)
    end

    it "changes environment" do
      subject.set_config("test")

      expect(subject.config).to eq(described_class.config("test"))
    end

    it "overrides environment configuration" do
      subject.set_config("test", :syspay_id => "test")

      expect(subject.config).to_not eq(described_class.config("test"))
    end

    it "overrides default/current configuration" do
      subject.set_config( :syspay_id => "test")
      subject.set_config( :syspay_passphrase => "test")

      expect(subject.config.syspay_passphrase).to eq("test")

      expect(subject.config.syspay_id).to eq("test")
    end

    it "appends ssl_options" do
      subject.set_config( :ssl_options => { :ca_file => "test_path" } )

      expect(subject.config.ssl_options[:ca_file]).to eql "test_path"
      subject.set_config( :ssl_options => { :verify_mode => 1 } )

      expect(subject.config.ssl_options[:verify_mode]).to eql 1

      expect(subject.config.ssl_options[:ca_file]).to eql "test_path"
    end

    it "sets configuration without loading configuration File" do
      described_class.configurations = nil

      expect {
        subject.config
      }.to raise_error Errno::ENOENT

      subject.set_config( :syspay_id => "test" )

      expect(subject.config).to be_a(described_class)
    end
  end
end