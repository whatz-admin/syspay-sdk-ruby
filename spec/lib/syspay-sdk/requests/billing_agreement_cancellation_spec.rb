require 'spec_helper'

describe SyspaySDK::Requests::BillingAgreementCancellation do
  it 'is a SyspaySDK::Requests::BaseClass' do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe 'Constants' do
    it "has a METHOD class constant set to 'POST'" do
      expect(described_class::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/billing-agreement/:billing_agreement_id/cancel'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/billing-agreement/:billing_agreement_id/cancel')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:billing_agreement_id) }
  end

  describe 'Initialize' do
    it 'can be initialized with a billing_agreement_id parameter' do
      billing_agreement_cancellation = described_class.new 'test_country'
      expect(billing_agreement_cancellation.billing_agreement_id).to eq('test_country')
    end

    it 'can be initialized without arguments' do
      billing_agreement_cancellation = described_class.new
      expect(billing_agreement_cancellation.billing_agreement_id).to be_nil
    end
  end

  it { is_expected.to respond_to(:http_method) }

  describe '#http_method' do
    it 'returns the METHOD constant' do
      expect(subject.http_method).to eq(described_class::METHOD)
    end
  end

  it { is_expected.to respond_to(:path) }

  describe '#path' do
    it 'returns the PATH constant' do
      expect(subject.path).to eq(described_class::PATH)
    end
    it 'returns the PATH constant with billing_agreement_id if exists' do
      with_billing_agreement_id = described_class.new 'test_billing_agreement_id'
      expect(with_billing_agreement_id.path).to eq(described_class::PATH.gsub(/:billing_agreement_id/, 'test_billing_agreement_id'))
    end
  end

  it { is_expected.to respond_to(:build_response) }

  describe '#build_response' do
    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        subject.build_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain billing_agreement" do
      expect do
        subject.build_response(test: 'test')
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'returns an SyspaySDK::Entities::BillingAgreement' do
      expect(subject.build_response(billing_agreement: {})).to be_a(SyspaySDK::Entities::BillingAgreement)
    end
  end
end
