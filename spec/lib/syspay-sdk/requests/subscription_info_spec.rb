describe SyspaySDK::Requests::SubscriptionInfo do
  it 'is a SyspaySDK::Requests::BaseClass' do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe 'Constants' do
    it "has a METHOD class constant set to 'GET'" do
      expect(described_class::METHOD).to eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/subscription/'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/subscription/')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:subscription_id) }
  end

  describe 'Initialize' do
    it 'can be initialized with a subscription_id parameter' do
      plan_info = described_class.new 'id'
      expect(plan_info.subscription_id).to eq('id')
    end

    it 'can be initialized without arguments' do
      plan_info = described_class.new
      expect(plan_info.subscription_id).to be_nil
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
    it 'returns the PATH constant with subscription_id if exists' do
      with_subscription_id = described_class.new
      with_subscription_id.subscription_id = 'test_subscription_id'

      expect(with_subscription_id.path).to eq("#{described_class::PATH}test_subscription_id")
    end
  end

  describe '#build_response' do
    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        subject.build_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain subscription" do
      expect do
        subject.build_response(test: 'test')
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'returns an SyspaySDK::Entities::Subscription' do
      expect(subject.build_response(subscription: {})).to be_a(SyspaySDK::Entities::Subscription)
    end

    it 'sets the redirect attribute of subscription' do
      subscription = subject.build_response(subscription: {}, redirect: 'test_redirect')
      expect(subscription.redirect).to eq('test_redirect')
    end
  end
end
