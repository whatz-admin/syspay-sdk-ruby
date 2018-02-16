describe SyspaySDK::Requests::RefundInfo do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      expect(described_class::METHOD).to eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/refund/'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/refund/')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:refund_id) }
  end

  describe "Initialize" do
    it "can be initialized with a refund_id parameter" do
      plan_info = described_class.new "id"
      expect(plan_info.refund_id).to eq("id")
    end

    it "can be initialized without arguments" do
      plan_info = described_class.new
      expect(plan_info.refund_id).to be_nil
    end
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

    it "returns the PATH constant with refund_id if exists" do
      with_refund_id = described_class.new
      with_refund_id.refund_id = "test_refund_id"
      expect(with_refund_id.get_path).to eq("#{described_class::PATH}test_refund_id")
    end
  end

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain refund" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Refund" do
      expect(subject.build_response({ refund: {} })).to be_a(SyspaySDK::Entities::Refund)
    end
  end
end
