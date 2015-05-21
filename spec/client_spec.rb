require "spec_helper"

describe Syspay::SDK::Client do
  it "is initialized with the values set in configuration" do
    client = Syspay::SDK::Client.new
    client.syspay_id.should eq(Config.config.syspay_id)
    client.syspay_passphrase.should eq(Config.config.syspay_passphrase)
    client.syspay_base_url.should eq(Config.config.syspay_base_url)
  end

  it "has a username" do
    should respond_to(:syspay_id)
  end

  it "has a secret" do
    should respond_to(:syspay_passphrase)
  end

  it "has a base_url" do
    should respond_to(:syspay_base_url)
  end

  it "has a response_body" do
    should respond_to(:response_body)
  end

  it "has a response_headers" do
    should respond_to(:response_headers)
  end

  it "has a response_data" do
    should respond_to(:response_data)
  end

  it "has a request_body" do
    should respond_to(:request_body)
  end

  it "has a request_headers" do
    should respond_to(:request_headers)
  end

  it "has a request_params" do
    should respond_to(:request_params)
  end

  it "has a request_id" do
    should respond_to(:request_id)
  end

  it "should respond to generate_auth_header" do
      should respond_to(:generate_auth_header)
  end

  describe "generate_auth_header" do
    it "returns a properly formatted x-wsse Header" do
      subject.generate_auth_header.should match(/AuthToken MerchantAPILogin=".*", PasswordDigest=".*", Nonce=".*", Created="\d*"/)
    end
  end
end