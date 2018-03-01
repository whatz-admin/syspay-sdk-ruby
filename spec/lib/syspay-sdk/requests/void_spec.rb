describe SyspaySDK::Requests::Void do
  it 'is a SyspaySDK::Requests::BaseClass' do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe 'Constants' do
    it "has a METHOD class constant set to 'POST'" do
      expect(described_class::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/payment/:payment_id/void'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/payment/:payment_id/void')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:payment_id) }
  end

  describe 'Initialize' do
    it 'can be initialized with a payment_id parameter' do
      subscription_cancellation = described_class.new 'test_payment_id'
      expect(subscription_cancellation.payment_id).to eq('test_payment_id')
    end

    it 'can be initialized without arguments' do
      subscription_cancellation = described_class.new
      expect(subscription_cancellation.payment_id).to be_nil
    end
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

    it 'returns the PATH constant with payment_id if exists' do
      with_payment_id = described_class.new 'test_payment_id'
      expect(with_payment_id.path).to eq(described_class::PATH.gsub(/:payment_id/, 'test_payment_id'))
    end
  end

  describe '#build_response' do
    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        subject.build_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain payment" do
      expect do
        subject.build_response(test: 'test')
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'returns an SyspaySDK::Entities::Payment' do
      expect(subject.build_response(payment: {})).to be_a(SyspaySDK::Entities::Payment)
    end

    it 'sets the redirect attribute of payment' do
      payment = subject.build_response(payment: {}, redirect: 'test_redirect')
      expect(payment.redirect).to eq('test_redirect')
    end
  end
end
