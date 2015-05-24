require 'spec_helper'

describe SyspaySDK::Entities::Customer do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'customer'" do
      SyspaySDK::Entities::Customer::TYPE.should eq('customer')
    end
  end

  describe "Attributes" do
    it { should respond_to(:email) }
    it { should respond_to(:language) }
    it { should respond_to(:ip) }
    it { should respond_to(:mobile) }
  end

  let (:response) do
    {
      email: "code",
      language: "name",
      ip: "url",
      mobile: "mobile"
    }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::Customer.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a Customer object" do
      SyspaySDK::Entities::Customer.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::Customer)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::Customer.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    before(:each) do
      @customer = SyspaySDK::Entities::Customer.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @customer.raw.should eq(response)
    end

    it "sets instance email attribute using value in response" do
      @customer.email.should eq(response[:email])
    end

    it "sets instance language attribute using value in response" do
      @customer.language.should eq(response[:language])
    end

    it "sets instance ip attribute using value in response" do
      @customer.ip.should eq(response[:ip])
    end

    it "sets instance mobile attribute using value in response" do
      @customer.mobile.should eq(response[:mobile])
    end
  end

  it "responds to #to_hash" do
    subject.should respond_to(:to_hash)
  end

  describe "#to_hash" do
    let(:subject) {
      SyspaySDK::Entities::Customer.build_from_response(response)
    }

    it "returns the payment converted to a hash" do
      subject.to_hash.should include(email: response[:email])
      subject.to_hash.should include(language: response[:language])
      subject.to_hash.should include(ip: response[:ip])
      subject.to_hash.should include(mobile: response[:mobile])
    end
  end
end
