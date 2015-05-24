require 'spec_helper'

describe SyspaySDK::Requests::IpAddresses do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      SyspaySDK::Requests::IpAddresses::METHOD.should eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/system-ip/'" do
      SyspaySDK::Requests::IpAddresses::PATH.should eq('/api/v1/merchant/system-ip/')
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain ip_addresses" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if ip_addresses is not an array" do
      lambda do
        subject.build_response({ip_addresses: {}})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::BillingAgreement" do
      subject.build_response({ ip_addresses: [] }).should be_a(Array)
    end
  end
end
