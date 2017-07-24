require 'spec_helper'

describe SyspaySDK::Requests::SubscriptionRebill do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::SubscriptionRebill::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/subscription/:subscription_id/rebill'" do
      SyspaySDK::Requests::SubscriptionRebill::PATH.should eq('/api/v1/merchant/subscription/:subscription_id/rebill')
    end
  end

  describe "Attributes" do
    it { should respond_to(:subscription_id) }
    it { should respond_to(:reference) }
    it { should respond_to(:amount) }
    it { should respond_to(:currency) }
    it { should respond_to(:description) }
    it { should respond_to(:ems_url) }
    it { should respond_to(:extra) }
  end

  describe "Initialize" do
    it "can be initialized with a subscription_id parameter" do
      subscription_rebill = SyspaySDK::Requests::SubscriptionRebill.new "id"
      subscription_rebill.subscription_id.should eq("id")
    end

    it "can be initialized without arguments" do
      subscription_rebill = SyspaySDK::Requests::SubscriptionRebill.new
      subscription_rebill.subscription_id.should be_nil
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::SubscriptionRebill::PATH)
    end
    it "returns the PATH constant with subscription_id if exists" do
      with_subscription_id = SyspaySDK::Requests::SubscriptionRebill.new "test_subscription_id"
      with_subscription_id.get_path.should eq(SyspaySDK::Requests::SubscriptionRebill::PATH.gsub(/:subscription_id/, "test_subscription_id"))
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the payment" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Payment" do
      subject.build_response({ payment: {} }).should be_a(SyspaySDK::Entities::Payment)
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    describe "the returned hash" do
      it "contains the reference" do
        subject.reference = "reference"
        subject.get_data.should include(reference: "reference")
      end
      it "contains the amount" do
        subject.amount = "amount"
        subject.get_data.should include(amount: "amount")
      end
      it "contains the currency" do
        subject.currency = "currency"
        subject.get_data.should include(currency: "currency")
      end
      it "contains the description" do
        subject.description = "description"
        subject.get_data.should include(description: "description")
      end
      it "contains the extra" do
        subject.extra = "extra"
        subject.get_data.should include(extra: "extra")
      end
      it "contains the ems_url" do
        subject.ems_url = "ems_url"
        subject.get_data.should include(ems_url: "ems_url")
      end
    end
  end
end
