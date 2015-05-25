require 'spec_helper'

describe SyspaySDK::Requests::Refund do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::Refund::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/refund'" do
      SyspaySDK::Requests::Refund::PATH.should eq('/api/v1/merchant/refund')
    end
  end

  describe "Attributes" do
    it { should respond_to(:payment_id) }
    it { should respond_to(:ems_url) }
    it { should respond_to(:refund) }
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the refund" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Refund" do
      subject.build_response({ refund: {} }).should be_a(SyspaySDK::Entities::Refund)
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    describe "the returned hash" do
      it "contains a hash for the refund" do
        subject.refund = SyspaySDK::Entities::Refund.new
        subject.get_data.should include(subject.refund.to_hash)
      end

      it "contains the payment_id" do
        subject.payment_id = "payment_id"
        subject.get_data.should include(payment_id: "payment_id")
      end

      it "contains the ems_url when it exists" do
        subject.get_data.should_not include(ems_url: nil)
        subject.ems_url = "ems_url"
        subject.get_data.should include(ems_url: "ems_url")
      end
    end
  end
end
