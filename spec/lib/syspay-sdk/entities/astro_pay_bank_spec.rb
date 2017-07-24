require 'spec_helper'

describe SyspaySDK::Entities::AstroPayBank do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Attributes" do
    it { should respond_to(:code) }
    it { should respond_to(:name) }
    it { should respond_to(:logo_url) }
  end

  it "responds to ::build_from_response" do
    SyspaySDK::Entities::AstroPayBank.should respond_to(:build_from_response)
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::AstroPayBank.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a AstroPayBank object" do
      SyspaySDK::Entities::AstroPayBank.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::AstroPayBank)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::AstroPayBank.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      {
        code: "code",
        name: "name",
        logo_url: "url"
      }
    end

    before(:each) do
      @astro_pay_bank = SyspaySDK::Entities::AstroPayBank.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @astro_pay_bank.raw.should eq(response)
    end

    it "sets instance code attribute using value in response" do
      @astro_pay_bank.code.should eq(response[:code])
    end

    it "sets instance name attribute using value in response" do
      @astro_pay_bank.name.should eq(response[:name])
    end

    it "sets instance logo_url attribute using value in response" do
      @astro_pay_bank.logo_url.should eq(response[:logo_url])
    end
  end
end