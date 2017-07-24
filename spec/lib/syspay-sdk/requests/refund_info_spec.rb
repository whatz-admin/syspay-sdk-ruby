require 'spec_helper'

describe SyspaySDK::Requests::RefundInfo do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      SyspaySDK::Requests::RefundInfo::METHOD.should eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/refund/'" do
      SyspaySDK::Requests::RefundInfo::PATH.should eq('/api/v1/merchant/refund/')
    end
  end

  describe "Attributes" do
    it { should respond_to(:refund_id) }
  end

  describe "Initialize" do
    it "can be initialized with a refund_id parameter" do
      plan_info = SyspaySDK::Requests::RefundInfo.new "id"
      plan_info.refund_id.should eq("id")
    end

    it "can be initialized without arguments" do
      plan_info = SyspaySDK::Requests::RefundInfo.new
      plan_info.refund_id.should be_nil
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::RefundInfo::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::RefundInfo::PATH)
    end
    it "returns the PATH constant with refund_id if exists" do
      with_refund_id = SyspaySDK::Requests::RefundInfo.new
      with_refund_id.refund_id = "test_refund_id"
      with_refund_id.get_path.should eq("#{SyspaySDK::Requests::RefundInfo::PATH}test_refund_id")
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain refund" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Refund" do
      subject.build_response({ refund: {} }).should be_a(SyspaySDK::Entities::Refund)
    end
  end
end
