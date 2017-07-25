require 'spec_helper'

describe SyspaySDK::Requests::BillingAgreementList do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      expect(described_class::METHOD).to eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/billing-agreements'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/billing-agreements')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:filters) }
  end

  describe "Initialize" do
    it "creates a hash of filter" do
      billing_agreement_list = described_class.new
      expect(billing_agreement_list.filters).to be_a(Hash)
    end
  end

  it { is_expected.to respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      expect(subject.get_method).to eq(described_class::METHOD)
    end
  end

  it { is_expected.to respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      expect(subject.get_path).to eq(described_class::PATH)
    end
  end

  it { is_expected.to respond_to(:add_filter) }

  describe "#add_filter" do
    it 'adds a filter to instance' do
      subject.add_filter :test, "test"
      expect(subject.filters).to include(test: "test")
    end
  end

  it { is_expected.to respond_to(:delete_filter) }

  describe "#delete_filter" do
    it 'deletes a filter from instance' do
      subject.add_filter :test, "test"
      subject.add_filter :test2, "test2"
      subject.delete_filter :test
      expect(subject.filters).to include(test2: "test2")
      expect(subject.filters).to_not include(test: "test")
    end
  end

  it { is_expected.to respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash containing the filters" do
      subject.add_filter :test, "test"
      subject.add_filter :test2, "test2"
      expect(subject.get_data).to eq(test: "test", test2: "test2")
    end
  end

  it { is_expected.to respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if the hash doesn't contain billing_agreements" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if billing_agreements is not an array" do
      expect {
        subject.build_response({billing_agreements: {}})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an Array of SyspaySDK::Entities::BillingAgreement" do
      expect(subject.build_response({ billing_agreements: [] })).to be_a(Array)
      expect(subject.build_response({ billing_agreements: [{id: 1}] }).first).to be_a(SyspaySDK::Entities::BillingAgreement)
    end
  end
end
