require 'spec_helper'

describe SyspaySDK::Requests::BillingAgreementInfo do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      SyspaySDK::Requests::BillingAgreementInfo::METHOD.should eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/billing-agreement/_ba_id_/cancel'" do
      SyspaySDK::Requests::BillingAgreementInfo::PATH.should eq('/api/v1/merchant/billing-agreement/')
    end
  end

  describe "Attributes" do
    it { should respond_to(:billing_agreement_id) }
  end

  describe "Initialize" do
    it "can be initialized with a billing_agreement_id parameter" do
      billing_agreement_cancellation = SyspaySDK::Requests::BillingAgreementInfo.new "id"
      billing_agreement_cancellation.billing_agreement_id.should eq("id")
    end

    it "can be initialized without arguments" do
      billing_agreement_cancellation = SyspaySDK::Requests::BillingAgreementInfo.new
      billing_agreement_cancellation.billing_agreement_id.should be_nil
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::BillingAgreementInfo::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::BillingAgreementInfo::PATH)
    end
    it "returns the PATH constant with billing_agreement_id if exists" do
      with_billing_agreement_id = SyspaySDK::Requests::BillingAgreementInfo.new "test_billing_agreement_id"
      with_billing_agreement_id.get_path.should eq("#{SyspaySDK::Requests::BillingAgreementInfo::PATH}test_billing_agreement_id")
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain billing_agreement" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::BillingAgreement" do
      subject.build_response({ billing_agreement: {} }).should be_a(SyspaySDK::Entities::BillingAgreement)
    end
  end
end
