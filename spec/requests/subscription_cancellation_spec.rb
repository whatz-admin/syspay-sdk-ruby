require 'spec_helper'

describe SyspaySDK::Requests::SubscriptionCancellation do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::SubscriptionCancellation::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/subscription/:subscription_id/cancel'" do
      SyspaySDK::Requests::SubscriptionCancellation::PATH.should eq('/api/v1/merchant/subscription/:subscription_id/cancel')
    end
  end

  describe "Attributes" do
    it { should respond_to(:subscription_id) }
  end

  describe "Initialize" do
    it "can be initialized with a subscription_id parameter" do
      subscription_cancellation = SyspaySDK::Requests::SubscriptionCancellation.new "test_country"
      subscription_cancellation.subscription_id.should eq("test_country")
    end

    it "can be initialized without arguments" do
      subscription_cancellation = SyspaySDK::Requests::SubscriptionCancellation.new
      subscription_cancellation.subscription_id.should be_nil
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::SubscriptionCancellation::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::SubscriptionCancellation::PATH)
    end
    it "returns the PATH constant with subscription_id if exists" do
      with_subscription_id = SyspaySDK::Requests::SubscriptionCancellation.new "test_subscription_id"
      with_subscription_id.get_path.should eq(SyspaySDK::Requests::SubscriptionCancellation::PATH.gsub(/:subscription_id/, "test_subscription_id"))
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain subscription" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Subscription" do
      subject.build_response({ subscription: {} }).should be_a(SyspaySDK::Entities::Subscription)
    end
  end
end