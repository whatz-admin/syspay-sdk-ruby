describe SyspaySDK::Requests::ChargebackList do
  it 'is a SyspaySDK::Requests::BaseClass' do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe 'Constants' do
    it "has a METHOD class constant set to 'GET'" do
      expect(described_class::METHOD).to eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/chargebacks'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/chargebacks')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:filters) }
  end

  describe 'Initialize' do
    it 'creates a hash of filter' do
      chargeback_list = described_class.new
      expect(chargeback_list.filters).to be_a(Hash)
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
  end

  it { is_expected.to respond_to(:add_filter) }

  describe '#add_filter' do
    it 'adds a filter to instance' do
      subject.add_filter :test, 'test'
      expect(subject.filters).to include(test: 'test')
    end
  end

  it { is_expected.to respond_to(:delete_filter) }

  describe '#delete_filter' do
    it 'deletes a filter from instance' do
      subject.add_filter :test, 'test'
      subject.add_filter :test2, 'test2'
      subject.delete_filter :test
      expect(subject.filters).to include(test2: 'test2')
      expect(subject.filters).to_not include(test: 'test')
    end
  end

  it { is_expected.to respond_to(:data) }

  describe '#data' do
    it 'returns a hash containing the filters' do
      subject.add_filter :test, 'test'
      subject.add_filter :test2, 'test2'
      expect(subject.data).to eq(test: 'test', test2: 'test2')
    end
  end

  it { is_expected.to respond_to(:build_response) }

  describe '#build_response' do
    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        subject.build_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if the hash doesn't contain chargebacks" do
      expect do
        subject.build_response(test: 'test')
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'raises a SyspaySDK::Exceptions::UnexpectedResponseError if chargebacks is not an array' do
      expect do
        subject.build_response(chargebacks: {})
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'returns an Array of SyspaySDK::Entities::Chargeback' do
      expect(subject.build_response(chargebacks: [])).to be_a(Array)
      expect(subject.build_response(chargebacks: [{ id: 1 }]).first).to be_a(SyspaySDK::Entities::Chargeback)
    end
  end
end
