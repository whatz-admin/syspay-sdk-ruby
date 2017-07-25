describe SyspaySDK::Entities::Eterminal do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'eterminal'" do
      expect(described_class::TYPE).to eq('eterminal')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:url) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      expect {
        described_class.build_from_response({ test: "test" })
      }.to_not raise_error
    end

    it "returns a Eterminal object" do
      expect(described_class.build_from_response({ test: "test" })).to be_a(described_class)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        described_class.build_from_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      { url: "url" }
    end

    before(:each) do
      @eterminal = described_class.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      expect(@eterminal.raw).to eq(response)
    end

    it "sets instance email attribute using value in response" do
      expect(@eterminal.url).to eq(response[:url])
    end
  end
end
