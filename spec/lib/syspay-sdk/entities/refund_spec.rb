describe SyspaySDK::Entities::Refund do
  it 'is a SyspaySDK::Entities::ReturnedEntity' do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe 'Constants' do
    it "has a TYPE class constant set to 'refund'" do
      expect(described_class::TYPE).to eq('refund')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:reference) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:currency) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:extra) }
    it { is_expected.to respond_to(:payment) }
    it { is_expected.to respond_to(:processing_time) }
  end

  describe '::build_from_response' do
    it "doesn't raise an error when called" do
      expect do
        described_class.build_from_response(test: 'test')
      end.to_not raise_error
    end

    it 'returns a Refund object' do
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
        reference: 'reference',
        amount: 'amount',
        currency: 'currency',
        description: 'description',
        extra: 'extra'
      }
    end

    before(:each) do
      @refund = described_class.build_from_response(response)
    end

    it 'sets instance raw attribute to response' do
      expect(@refund.raw).to eq(response)
    end

    it 'sets instance id attribute using value in response' do
      expect(@refund.id).to eq(response[:id])
    end

    it 'sets intance id attribute using value in response' do
      expect(@refund.id).to eq(response[:id])
    end

    it 'sets intance status attribute using value in response' do
      expect(@refund.status).to eq(response[:status])
    end

    it 'sets intance reference attribute using value in response' do
      expect(@refund.reference).to eq(response[:reference])
    end

    it 'sets intance amount attribute using value in response' do
      expect(@refund.amount).to eq(response[:amount])
    end

    it 'sets intance currency attribute using value in response' do
      expect(@refund.currency).to eq(response[:currency])
    end

    it 'sets intance description attribute using value in response' do
      expect(@refund.description).to eq(response[:description])
    end

    it 'sets intance extra attribute using value in response' do
      expect(@refund.extra).to eq(response[:extra])
    end

    it 'sets instance processing_time attribute using value in response' do
      processing_time = Date.new(2001, 2, 3)
      response[:processing_time] = processing_time.to_time.to_i
      expect(described_class.build_from_response(response).processing_time).to eq(processing_time)
    end

    it 'sets instance payment attribute using value in response' do
      response[:payment] = {}
      expect(described_class.build_from_response(response).payment).to be_a(SyspaySDK::Entities::Payment)
    end
  end
end
