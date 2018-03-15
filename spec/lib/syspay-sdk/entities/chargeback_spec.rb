describe SyspaySDK::Entities::Chargeback do
  it 'is a SyspaySDK::Entities::ReturnedEntity' do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe 'Constants' do
    it "has a TYPE class constant set to 'chargeback'" do
      expect(described_class::TYPE).to eq('chargeback')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:currency) }
    it { is_expected.to respond_to(:reason_code) }
    it { is_expected.to respond_to(:payment) }
    it { is_expected.to respond_to(:processing_time) }
    it { is_expected.to respond_to(:bank_time) }
  end

  describe '::build_from_response' do
    it "doesn't raise an error when called" do
      expect do
        described_class.build_from_response(test: 'test')
      end.to_not raise_error
    end

    it 'returns a Chargeback object' do
      expect(described_class.build_from_response(test: 'test')).to be_a(described_class)
    end

    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        described_class.build_from_response('test')
      end.to raise_error SyspaySDK::Exceptions::BadArgumentTypeError
    end

    let(:response) do
      {
        id: 'id',
        status: 'status',
        amount: 'amount',
        currency: 'currency',
        reason_code: 'reason_code'
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

    it 'sets instance amount attribute using value in response' do
      expect(@billing_agreement.amount).to eq(response[:amount])
    end

    it 'sets instance currency attribute using value in response' do
      expect(@billing_agreement.currency).to eq(response[:currency])
    end

    it 'sets instance reason_code attribute using value in response' do
      expect(@billing_agreement.reason_code).to eq(response[:reason_code])
    end

    it 'sets instance processing_time attribute using value in response' do
      processing_time = Time.now
      response[:processing_time] = processing_time.to_i
      expect(described_class.build_from_response(response).processing_time).to be_a(Time)
      expect(described_class.build_from_response(response).processing_time).to eq(Time.at(processing_time.to_i))
    end

    it 'sets instance bank_time attribute using value in response' do
      bank_time = Time.now
      response[:bank_time] = bank_time.to_i
      expect(described_class.build_from_response(response).bank_time).to be_a(Time)
      expect(described_class.build_from_response(response).bank_time).to eq(Time.at(bank_time.to_i))
    end

    it 'sets instance payment attribute using value in response' do
      response[:payment] = {}
      expect(described_class.build_from_response(response).payment).to be_a(SyspaySDK::Entities::Payment)
    end
  end
end
