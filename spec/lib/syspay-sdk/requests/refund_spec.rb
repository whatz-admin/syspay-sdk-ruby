describe SyspaySDK::Requests::Refund do
  it 'is a SyspaySDK::Requests::BaseClass' do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe 'Constants' do
    it "has a METHOD class constant set to 'POST'" do
      expect(described_class::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/refund'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/refund')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:payment_id) }
    it { is_expected.to respond_to(:ems_url) }
    it { is_expected.to respond_to(:refund) }
  end

  describe '#build_response' do
    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        subject.build_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the refund" do
      expect do
        subject.build_response(test: 'test')
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'returns an SyspaySDK::Entities::Refund' do
      expect(subject.build_response(refund: {})).to be_a(SyspaySDK::Entities::Refund)
    end
  end

  describe '#data' do
    it 'returns a hash' do
      expect(subject.data).to be_a(Hash)
    end

    describe 'the returned hash' do
      it 'contains a hash for the refund' do
        subject.refund = SyspaySDK::Entities::Refund.new
        expect(subject.data).to include(subject.refund.to_hash)
      end

      it 'contains the payment_id' do
        subject.payment_id = 'payment_id'
        expect(subject.data).to include(payment_id: 'payment_id')
      end

      it 'contains the ems_url when it exists' do
        expect(subject.data).to_not include(ems_url: nil)
        subject.ems_url = 'ems_url'
        expect(subject.data).to include(ems_url: 'ems_url')
      end
    end
  end
end
