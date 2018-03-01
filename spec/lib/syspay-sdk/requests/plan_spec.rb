describe SyspaySDK::Requests::Plan do
  it 'is a SyspaySDK::Requests::BaseClass' do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe 'Constants' do
    it "has a METHOD class constant set to 'POST'" do
      expect(described_class::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/plan'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/plan')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:plan) }
  end

  describe '#http_method' do
    it 'returns the METHOD constant' do
      expect(subject.http_method).to eq(described_class::METHOD)
    end
  end

  describe '#path' do
    it 'returns the PATH constant' do
      expect(subject.path).to eq(described_class::PATH)
    end
  end

  describe '#build_response' do
    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        subject.build_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the plan" do
      expect do
        subject.build_response(test: 'test')
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'returns an SyspaySDK::Entities::Plan' do
      expect(subject.build_response(plan: {})).to be_a(SyspaySDK::Entities::Plan)
    end
  end

  describe '#data' do
    it 'returns a hash' do
      expect(subject.data).to be_a(Hash)
    end

    it 'returns the plan as a hash' do
      subject.plan = SyspaySDK::Entities::Plan.new
      expect(subject.data).to eq(subject.plan.to_hash)
    end
  end
end
