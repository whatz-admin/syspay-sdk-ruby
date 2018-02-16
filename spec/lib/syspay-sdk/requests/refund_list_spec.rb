describe SyspaySDK::Requests::RefundList do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      expect(described_class::METHOD).to eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/refunds/'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/refunds/')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:filters) }
  end

  describe "Initialize" do
    it "creates a hash of filter" do
      refund_list = described_class.new
      expect(refund_list.filters).to be_a(Hash)
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
  end

  describe "#add_filter" do
    it 'adds a filter to instance' do
      subject.add_filter :test, "test"
      expect(subject.filters).to include(test: "test")
    end
  end

  describe "#delete_filter" do
    it 'deletes a filter from instance' do
      subject.add_filter :test, "test"
      subject.add_filter :test2, "test2"
      subject.delete_filter :test
      expect(subject.filters).to include(test2: "test2")
      expect(subject.filters).to_not include(test: "test")
    end
  end

  describe "#get_data" do
    it "returns a hash containing the filters" do
      subject.add_filter :test, "test"
      subject.add_filter :test2, "test2"
      expect(subject.get_data).to eq(test: "test", test2: "test2")
    end
  end

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if the hash doesn't contain refunds" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if refunds is not an array" do
      expect {
        subject.build_response({refunds: {}})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an Array of SyspaySDK::Entities::Payment" do
      expect(subject.build_response({ refunds: [] })).to be_a(Array)
      expect(subject.build_response({ refunds: [{id: 1}] }).first).to be_a(SyspaySDK::Entities::Refund)
    end
  end
end