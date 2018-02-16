describe SyspaySDK::Requests::Subscription do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a FLOW_API class constant set to 'API'" do
      expect(described_class::FLOW_API).to eq('API')
    end

    it "has a FLOW_BUYER class constant set to 'BUYER'" do
      expect(described_class::FLOW_BUYER).to eq('BUYER')
    end

    it "has a FLOW_SELLER class constant set to 'SELLER'" do
      expect(described_class::FLOW_SELLER).to eq('SELLER')
    end

    it "has a METHOD class constant set to 'POST'" do
      expect(described_class::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/subscription'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/subscription')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:flow) }
    it { is_expected.to respond_to(:subscription) }
    it { is_expected.to respond_to(:customer) }
    it { is_expected.to respond_to(:method) }
    it { is_expected.to respond_to(:threatmetrix_session_id) }
    it { is_expected.to respond_to(:creditcard) }
    it { is_expected.to respond_to(:use_subscription) }
    it { is_expected.to respond_to(:use_billing_agreement) }
  end

  describe "#get_method" do
    it "returns the METHOD constant" do
      expect(subject.get_method).to eq(described_class::METHOD)
    end
  end

  describe "#get_path" do
    it "returns the PATH constant" do
      expect(subject.get_path).to eq(described_class::PATH)
    end
  end

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the subscription" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Subscription" do
      expect(subject.build_response({ subscription: {} })).to be_a(SyspaySDK::Entities::Subscription)
    end

    let(:data) do
      {
        subscription: {id: 137},
        redirect: "redirect"
      }
    end

    it "returns a SyspaySDK::Entities::Subscription setup according to data passed in" do
      subscription = subject.build_response(data)
      expect(subscription.id).to eq(data[:subscription][:id])
      expect(subscription.redirect).to eq(data[:redirect])
    end
  end

  describe "#get_data" do
    it "returns a hash" do
      expect(subject.get_data).to be_a(Hash)
    end

    describe "the returned hash" do
      it "contains the flow" do
        subject.flow = described_class::FLOW_API
        expect(subject.get_data).to include(flow: described_class::FLOW_API)
      end

      it "contains a hash for the subscription" do
        subscription = SyspaySDK::Entities::Subscription.new
        subscription.id = 159
        subject.subscription = subscription
        expect(subject.get_data).to include(subscription: subscription.to_hash)
      end

      it "contains a hash for the customer" do
        customer = SyspaySDK::Entities::Customer.new
        customer.email = "test_email"
        subject.customer = customer
        expect(subject.get_data).to include(customer: customer.to_hash)
      end

      it "contains the method" do
        subject.method = "method"
        expect(subject.get_data).to include(method: "method")
      end

      it "contains the threatmetrix_session_id" do
        subject.threatmetrix_session_id = 1
        expect(subject.get_data).to include(threatmetrix_session_id: 1)
      end

      it "contains a hash for the creditcard" do
        creditcard = SyspaySDK::Entities::CreditCard.new
        creditcard.number = "1234"
        subject.creditcard = creditcard
        expect(subject.get_data).to include(creditcard: creditcard.to_hash)
      end

      it "contains the use_subscription" do
        subject.use_subscription = true
        expect(subject.get_data).to include(use_subscription: true)
      end

      it "contains the use_billing_agreement" do
        subject.use_billing_agreement = true
        expect(subject.get_data).to include(use_billing_agreement: true)
      end
    end
  end
end
