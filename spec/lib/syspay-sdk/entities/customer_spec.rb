describe SyspaySDK::Entities::Customer do
  it 'is a SyspaySDK::Entities::ReturnedEntity' do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe 'Constants' do
    it "has a TYPE class constant set to 'customer'" do
      expect(described_class::TYPE).to eq('customer')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:language) }
    it { is_expected.to respond_to(:ip) }
    it { is_expected.to respond_to(:mobile) }
  end

  let(:response) do
    {
      id: 'id',
      email: 'code',
      language: 'name',
      ip: 'url',
      mobile: 'mobile'
    }
  end

  describe '::build_from_response' do
    it "doesn't raise an error when called" do
      expect do
        described_class.build_from_response(test: 'test')
      end.to_not raise_error
    end

    it 'returns a Customer object' do
      expect(described_class.build_from_response(test: 'test')).to be_a(described_class)
    end

    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        described_class.build_from_response('test')
      end.to raise_error SyspaySDK::Exceptions::BadArgumentTypeError
    end

    before(:each) do
      @customer = described_class.build_from_response(response)
    end

    it 'sets instance raw attribute to response' do
      expect(@customer.raw).to eq(response)
    end

    it 'sets instance id attribute using value in response' do
      expect(@customer.id).to eq(response[:id])
    end

    it 'sets instance email attribute using value in response' do
      expect(@customer.email).to eq(response[:email])
    end

    it 'sets instance language attribute using value in response' do
      expect(@customer.language).to eq(response[:language])
    end

    it 'sets instance ip attribute using value in response' do
      expect(@customer.ip).to eq(response[:ip])
    end

    it 'sets instance mobile attribute using value in response' do
      expect(@customer.mobile).to eq(response[:mobile])
    end
  end

  describe '#to_hash' do
    let(:subject) do
      described_class.build_from_response(response)
    end

    it 'returns the payment converted to a hash' do
      hash = subject.to_hash

      expect(hash).to include(id: response[:id])
      expect(hash).to include(email: response[:email])
      expect(hash).to include(language: response[:language])
      expect(hash).to include(ip: response[:ip])
      expect(hash).to include(mobile: response[:mobile])
    end
  end
end
