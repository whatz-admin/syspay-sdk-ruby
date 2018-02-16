require 'spec_helper'

describe SyspaySDK::Requests::SubscriptionRebill do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      expect(described_class::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/subscription/:subscription_id/rebill'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/subscription/:subscription_id/rebill')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:subscription_id) }
    it { is_expected.to respond_to(:reference) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:currency) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:ems_url) }
    it { is_expected.to respond_to(:extra) }
  end

  describe "Initialize" do
    it "can be initialized with a subscription_id parameter" do
      subscription_rebill = described_class.new "id"
      expect(subscription_rebill.subscription_id).to eq("id")
    end

    it "can be initialized without arguments" do
      subscription_rebill = described_class.new
      expect(subscription_rebill.subscription_id).to be_nil
    end
  end

  describe "#get_path" do
    it "returns the PATH constant" do
      expect(subject.get_path).to eq(described_class::PATH)
    end
    it "returns the PATH constant with subscription_id if exists" do
      with_subscription_id = described_class.new "test_subscription_id"
      expect(with_subscription_id.get_path).to eq(described_class::PATH.gsub(/:subscription_id/, "test_subscription_id"))
    end
  end

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the payment" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Payment" do
      expect(subject.build_response({ payment: {} })).to be_a(SyspaySDK::Entities::Payment)
    end
  end

  describe "#get_data" do
    it "returns a hash" do
      expect(subject.get_data).to be_a(Hash)
    end

    describe "the returned hash" do
      it "contains the reference" do
        subject.reference = "reference"
        expect(subject.get_data).to include(reference: "reference")
      end
      it "contains the amount" do
        subject.amount = "amount"
        expect(subject.get_data).to include(amount: "amount")
      end
      it "contains the currency" do
        subject.currency = "currency"
        expect(subject.get_data).to include(currency: "currency")
      end
      it "contains the description" do
        subject.description = "description"
        expect(subject.get_data).to include(description: "description")
      end
      it "contains the extra" do
        subject.extra = "extra"
        expect(subject.get_data).to include(extra: "extra")
      end
      it "contains the ems_url" do
        subject.ems_url = "ems_url"
        expect(subject.get_data).to include(ems_url: "ems_url")
      end
    end
  end
end
