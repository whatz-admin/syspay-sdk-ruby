describe SyspaySDK::Requests::Confirm do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      expect(SyspaySDK::Requests::Confirm::METHOD).to eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/payment/:payment_id/confirm'" do
      expect(SyspaySDK::Requests::Confirm::PATH).to eq('/api/v1/merchant/payment/:payment_id/confirm')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:payment_id) }
  end

  describe "Initialize" do
    it "can be initialized with a payment_id parameter" do
      confirm = SyspaySDK::Requests::Confirm.new "payment_id"
      expect(confirm.payment_id).to eq("payment_id")
    end

    it "can be initialized without arguments" do
      confirm = SyspaySDK::Requests::Confirm.new
      expect(confirm.payment_id).to be_nil
    end
  end

  it { is_expected.to respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      expect(subject.get_method).to eq(SyspaySDK::Requests::Confirm::METHOD)
    end
  end

  it { is_expected.to respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      expect(subject.get_path).to eq(SyspaySDK::Requests::Confirm::PATH)
    end
    it "returns the PATH constant with payment_id if exists" do
      with_payment_id = SyspaySDK::Requests::Confirm.new "test_payment_id"
      expect(with_payment_id.get_path).to eq(SyspaySDK::Requests::Confirm::PATH.gsub(/:payment_id/, "test_payment_id"))
    end
  end

  it { is_expected.to respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain payment" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Payment" do
      expect(subject.build_response({ payment: {} })).to be_a(SyspaySDK::Entities::Payment)
    end

    it "sets the redirect attribute fo payment" do
      payment = subject.build_response({ payment: {}, redirect: "test_redirect" })
      expect(payment.redirect).to eq("test_redirect")
    end
  end
end
