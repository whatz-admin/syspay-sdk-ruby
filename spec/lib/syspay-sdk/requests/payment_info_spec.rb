require 'spec_helper'

describe SyspaySDK::Requests::PaymentInfo do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      SyspaySDK::Requests::PaymentInfo::METHOD.should eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/payment/'" do
      SyspaySDK::Requests::PaymentInfo::PATH.should eq('/api/v1/merchant/payment/')
    end
  end

  describe "Attributes" do
    it { should respond_to(:payment_id) }
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::PaymentInfo::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::PaymentInfo::PATH)
    end
    it "returns the PATH constant with payment_id if exists" do
      with_payment_id = SyspaySDK::Requests::PaymentInfo.new
      with_payment_id.payment_id = "test_payment_id"
      with_payment_id.get_path.should eq("#{SyspaySDK::Requests::PaymentInfo::PATH}test_payment_id")
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain payment" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Payment" do
      subject.build_response({ payment: {} }).should be_a(SyspaySDK::Entities::Payment)
    end

    it "sets the redirect attribute of payment" do
      payment = subject.build_response({ payment: {}, redirect: "test_redirect" })
      payment.redirect.should eq("test_redirect")
    end
  end
end
