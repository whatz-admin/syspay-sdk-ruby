describe SyspaySDK::Entities::BillingAgreement do
  it 'is a SyspaySDK::Entities::ReturnedEntity' do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe 'Constants' do
    it "has a TYPE class constant set to 'billing_agreement'" do
      expect(described_class::TYPE).to eq('billing_agreement')
    end

    it "has a STATUS_PENDING class constant set to 'PENDING'" do
      expect(described_class::STATUS_PENDING).to eq('PENDING')
    end
    it "has a STATUS_ACTIVE class constant set to 'ACTIVE'" do
      expect(described_class::STATUS_ACTIVE).to eq('ACTIVE')
    end
    it "has a STATUS_CANCELLED class constant set to 'CANCELLED'" do
      expect(described_class::STATUS_CANCELLED).to eq('CANCELLED')
    end
    it "has a STATUS_ENDED class constant set to 'ENDED'" do
      expect(described_class::STATUS_ENDED).to eq('ENDED')
    end
    it "has a END_REASON_UNSUBSCRIBED_MERCHANT class constant set to 'UNSUBSCRIBED_MERCHANT'" do
      expect(described_class::END_REASON_UNSUBSCRIBED_MERCHANT).to eq('UNSUBSCRIBED_MERCHANT')
    end
    it "has a END_REASON_UNSUBSCRIBED_ADMIN class constant set to 'UNSUBSCRIBED_ADMIN'" do
      expect(described_class::END_REASON_UNSUBSCRIBED_ADMIN).to eq('UNSUBSCRIBED_ADMIN')
    end
    it "has a END_REASON_SUSPENDED_EXPIRED class constant set to 'SUSPENDED_EXPIRED'" do
      expect(described_class::END_REASON_SUSPENDED_EXPIRED).to eq('SUSPENDED_EXPIRED')
    end
    it "has a END_REASON_SUSPENDED_CHARGEBACK class constant set to 'SUSPENDED_CHARGEBACK'" do
      expect(described_class::END_REASON_SUSPENDED_CHARGEBACK).to eq('SUSPENDED_CHARGEBACK')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:currency) }
    it { is_expected.to respond_to(:extra) }
    it { is_expected.to respond_to(:end_reason) }
    it { is_expected.to respond_to(:payment_method) }
    it { is_expected.to respond_to(:customer) }
    it { is_expected.to respond_to(:expiration_date) }
    it { is_expected.to respond_to(:redirect) }
    it { is_expected.to respond_to(:description) }
  end

  describe '::build_from_response' do
    it "doesn't raise an error when called" do
      expect do
        described_class.build_from_response(test: 'test')
      end.to_not raise_error
    end

    it 'returns a BillingAgreement object' do
      expect(described_class.build_from_response(test: 'test')).to be_a(described_class)
    end

    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        described_class.build_from_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let(:response) do
      {
        id: 'id',
        status: 'status',
        currency: 'currency',
        extra: 'extra',
        end_reason: 'end_reason'
      }
    end

    before(:each) do
      @billing_agreement = described_class.build_from_response(response)
    end

    it 'sets instance raw attribute to response' do
      expect(@billing_agreement.raw).to eq(response)
    end

    it 'sets instance id attribute using value in response' do
      expect(@billing_agreement.id).to eq(response[:id])
    end

    it 'sets instance status attribute using value in response' do
      expect(@billing_agreement.status).to eq(response[:status])
    end

    it 'sets instance currency attribute using value in response' do
      expect(@billing_agreement.currency).to eq(response[:currency])
    end

    it 'sets instance extra attribute using value in response' do
      expect(@billing_agreement.extra).to eq(response[:extra])
    end

    it 'sets instance end_reason attribute using value in response' do
      expect(@billing_agreement.end_reason).to eq(response[:end_reason])
    end

    it 'sets instance expiration_date attribute using value in response' do
      expiration_date = Date.new(2001, 2, 3)
      response[:expiration_date] = expiration_date.to_time.to_i
      expect(described_class.build_from_response(response).expiration_date).to eq(expiration_date)
    end

    it 'sets instance payment_method attribute using value in response' do
      response[:payment_method] = {}
      expect(described_class.build_from_response(response).payment_method).to be_a(SyspaySDK::Entities::PaymentMethod)
    end

    it 'sets instance customer attribute using value in response' do
      response[:customer] = {}
      expect(described_class.build_from_response(response).customer).to be_a(SyspaySDK::Entities::Customer)
    end
  end
end
