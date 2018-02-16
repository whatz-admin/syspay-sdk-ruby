describe SyspaySDK::Requests::ChargebackInfo do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      expect(described_class::METHOD).to eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/chargeback/'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/chargeback/')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:chargeback_id) }
  end

  describe "Initialize" do
    it "can be initialized with a chargeback_id parameter" do
      billing_agreement_cancellation = described_class.new "id"
      expect(billing_agreement_cancellation.chargeback_id).to eq("id")
    end

    it "can be initialized without arguments" do
      billing_agreement_cancellation = described_class.new
      expect(billing_agreement_cancellation.chargeback_id).to be_nil
    end
  end

  it { is_expected.to respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      expect(subject.get_method).to eq(described_class::METHOD)
    end
  end

  it { is_expected.to respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      expect(subject.get_path).to eq(described_class::PATH)
    end
    it "returns the PATH constant with chargeback_id if exists" do
      with_test_chargeback_id = described_class.new "test_chargeback_id"
      expect(with_test_chargeback_id.get_path).to eq("#{described_class::PATH}test_chargeback_id")
    end
  end

  it { is_expected.to respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain billing_agreement" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::BillingAgreement" do
      expect(subject.build_response({ chargeback: {} })).to be_a(SyspaySDK::Entities::Chargeback)
    end
  end
end