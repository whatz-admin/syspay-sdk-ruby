describe SyspaySDK::Requests::Rebill do
  it 'is a SyspaySDK::Requests::BaseClass' do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe 'Constants' do
    it "has a METHOD class constant set to 'POST'" do
      expect(described_class::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/billing-agreement/:billing_agreement_id/rebill'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/billing-agreement/:billing_agreement_id/rebill')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:threatmetrix_session_id) }
    it { is_expected.to respond_to(:ems_url) }
    it { is_expected.to respond_to(:billing_agreement_id) }
    it { is_expected.to respond_to(:reference) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:currency) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:extra) }
    it { is_expected.to respond_to(:recipient_map) }
  end

  describe 'Initialize' do
    it 'can be initialized with a billing_agreement_id parameter' do
      rebill = described_class.new 'id'
      expect(rebill.billing_agreement_id).to eq('id')
    end

    it 'can be initialized without arguments' do
      rebill = described_class.new
      expect(rebill.billing_agreement_id).to be_nil
    end
  end

  describe '#path' do
    it 'returns the PATH constant' do
      expect(subject.path).to eq(described_class::PATH)
    end
    it 'returns the PATH constant with billing_agreement_id if exists' do
      with_billing_agreement_id = described_class.new 'test_billing_agreement_id'
      expect(with_billing_agreement_id.path).to eq(described_class::PATH.gsub(/:billing_agreement_id/, 'test_billing_agreement_id'))
    end
  end

  describe '#assign_recipient_map' do
    it 'sets the instance recipient_map attribute properly' do
      recipient_map = [SyspaySDK::Entities::PaymentRecipient.new, SyspaySDK::Entities::PaymentRecipient.new]
      subject.assign_recipient_map(recipient_map)

      expect(subject.recipient_map).to eq(recipient_map)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when recipient_map doesn't contain only PaymentRecipient" do
      recipient_map = [SyspaySDK::Entities::PaymentRecipient.new, SyspaySDK::Entities::Payment.new]

      expect do
        subject.assign_recipient_map(recipient_map)
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end
  end

  describe '#add_recipient' do
    it 'adds a recipient to the instance recipient_map array' do
      recipient = SyspaySDK::Entities::PaymentRecipient.new
      subject.add_recipient recipient
      expect(subject.recipient_map).to include(recipient)
    end

    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when recipient is not a PaymentRecipient' do
      recipient = 'Not a PaymentRecipient'

      expect do
        subject.add_recipient recipient
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end
  end

  it { is_expected.to respond_to(:build_response) }

  describe '#build_response' do
    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        subject.build_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the payment" do
      expect do
        subject.build_response(test: 'test')
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'returns an SyspaySDK::Entities::Payment' do
      expect(subject.build_response(payment: {})).to be_a(SyspaySDK::Entities::Payment)
    end
  end

  it { is_expected.to respond_to(:data) }

  describe '#data' do
    it 'returns a hash' do
      expect(subject.data).to be_a(Hash)
    end

    describe 'the returned hash' do
      it 'contains the threatmetrix_session_id' do
        subject.threatmetrix_session_id = 'threatmetrix_session_id'
        expect(subject.data).to include(threatmetrix_session_id: 'threatmetrix_session_id')
      end

      it 'contains the ems_url' do
        subject.ems_url = 'ems_url'
        expect(subject.data).to include(ems_url: 'ems_url')
      end

      describe 'contains the payment hash which' do
        it 'is always present' do
          expect(subject.data.keys).to include(:payment)
        end

        it 'contains the reference' do
          subject.reference = 'reference'
          expect(subject.data[:payment]).to include(reference: 'reference')
        end

        it 'contains the amount' do
          subject.amount = 'amount'
          expect(subject.data[:payment]).to include(amount: 'amount')
        end

        it 'contains the currency' do
          subject.currency = 'currency'
          expect(subject.data[:payment]).to include(currency: 'currency')
        end

        it 'contains the description' do
          subject.description = 'description'
          expect(subject.data[:payment]).to include(description: 'description')
        end

        it 'contains the extra' do
          subject.extra = 'extra'
          expect(subject.data[:payment]).to include(extra: 'extra')
        end

        it 'contains the recipient_map' do
          recipient1 = SyspaySDK::Entities::PaymentRecipient.new
          recipient2 = SyspaySDK::Entities::PaymentRecipient.new
          subject.assign_recipient_map([recipient1, recipient2])
          expect(subject.data[:payment]).to include(recipient_map: [recipient1.to_hash, recipient2.to_hash])
        end
      end
    end
  end
end
