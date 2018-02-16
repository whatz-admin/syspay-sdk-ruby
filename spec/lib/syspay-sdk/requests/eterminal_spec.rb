describe SyspaySDK::Requests::Eterminal do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      expect(described_class::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to ' '/api/v1/merchant/eterminal'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/eterminal')
    end

    it "has a TYPE_ONESHOT class constant set to 'ONESHOT'" do
      expect(described_class::TYPE_ONESHOT).to eq('ONESHOT')
    end

    it "has a TYPE_SUBSCRIPTION class constant set to 'SUBSCRIPTION'" do
      expect(described_class::TYPE_SUBSCRIPTION).to eq('SUBSCRIPTION')
    end

    it "has a TYPE_PAYMENT_PLAN class constant set to 'PAYMENT_PLAN'" do
      expect(described_class::TYPE_PAYMENT_PLAN).to eq('PAYMENT_PLAN')
    end

    it "has a TYPE_PAYMENT_MANDATE class constant set to 'PAYMENT_MANDATE'" do
      expect(described_class::TYPE_PAYMENT_MANDATE).to eq('PAYMENT_MANDATE')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:website) }
    it { is_expected.to respond_to(:locked) }
    it { is_expected.to respond_to(:ems_url) }
    it { is_expected.to respond_to(:payment_redirect_url) }
    it { is_expected.to respond_to(:eterminal_redirect_url) }
    it { is_expected.to respond_to(:type) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:reference) }
    it { is_expected.to respond_to(:customer) }
    it { is_expected.to respond_to(:oneshot) }
    it { is_expected.to respond_to(:subscription) }
    it { is_expected.to respond_to(:payment_plan) }
    it { is_expected.to respond_to(:payment_mandate) }
    it { is_expected.to respond_to(:allowed_retries) }
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

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the eterminal" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Eterminal" do
      expect(subject.build_response({ eterminal: {} })).to be_a(SyspaySDK::Entities::Eterminal)
    end

    let(:data) do
      {
        eterminal: {url: "test_url"}
      }
    end

    it "returns a SyspaySDK::Entities::Eterminal setup according to data passed in" do
      eterminal = subject.build_response(data)
      expect(eterminal.url).to eq(data[:eterminal][:url])
    end
  end

  it { is_expected.to respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      expect(subject.get_data).to be_a(Hash)
    end

    describe "the returned hash" do
      it "contains a boolean for locked" do
        subject.locked = true
        expect(subject.get_data).to include(locked: true)

        subject.locked = nil
        expect(subject.get_data).to include(locked: false)
      end

      it "contains the type" do
        subject.type = described_class::TYPE_ONESHOT
        expect(subject.get_data).to include(type: described_class::TYPE_ONESHOT)
      end

      it "contains the website" do
        subject.website = "website"
        expect(subject.get_data).to include(website: "website")
      end

      it "contains the ems_url" do
        subject.ems_url = "ems_url"
        expect(subject.get_data).to include(ems_url: "ems_url")
      end

      it "contains the payment_redirect_url" do
        subject.payment_redirect_url = "payment_redirect_url"
        expect(subject.get_data).to include(payment_redirect_url: "payment_redirect_url")
      end

      it "contains the eterminal_redirect_url" do
        subject.eterminal_redirect_url = "eterminal_redirect_url"
        expect(subject.get_data).to include(eterminal_redirect_url: "eterminal_redirect_url")
      end

      it "contains the description" do
        subject.description = "description"
        expect(subject.get_data).to include(description: "description")
      end

      it "contains the reference" do
        subject.reference = "reference"
        expect(subject.get_data).to include(reference: "reference")
      end

      it "contains the customer" do
        subject.customer = "customer"
        expect(subject.get_data).to include(customer: "customer")
      end

      it "contains the oneshot" do
        subject.oneshot = "oneshot"
        expect(subject.get_data).to include(oneshot: "oneshot")
      end

      it "contains the subscription" do
        subject.subscription = "subscription"
        expect(subject.get_data).to include(subscription: "subscription")
      end

      it "contains the payment_plan" do
        subject.payment_plan = "payment_plan"
        expect(subject.get_data).to include(payment_plan: "payment_plan")
      end

      it "contains the payment_mandate" do
        subject.payment_mandate = "payment_mandate"
        expect(subject.get_data).to include(payment_mandate: "payment_mandate")
      end

      it "contains the allowed_retries" do
        subject.allowed_retries = "allowed_retries"
        expect(subject.get_data).to include(allowed_retries: "allowed_retries")
      end
    end
  end
end