describe SyspaySDK::Requests::AstroPayBank do
  it "is a SyspaySDK::Requests::BaseClass" do
    expect(subject).to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      expect(described_class::METHOD).to eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/astropay/banks/'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/astropay/banks/')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:country) }
  end

  describe "Initialize" do
    it "can be initialized with a country parameter" do
      astro_pay_bank = described_class.new "test_country"
      expect(astro_pay_bank.country).to eq("test_country")
    end

    it "can be initialized without arguments" do
      astro_pay_bank =described_class.new
      expect(astro_pay_bank.country).to be_nil
    end
  end

  describe "#get_method" do
    it "returns the METHOD constant" do
      expect(subject.get_method).to eq(described_class::METHOD)
    end
  end

  describe "#get_method" do
    it "returns the PATH constant" do
      expect(subject.get_path).to eq(described_class::PATH)
    end
    it "returns the PATH constant with country if exists" do
      with_country = described_class.new "test_country"
      expect(with_country.get_path).to eq("#{described_class::PATH}test_country")
    end
  end

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain banks" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an Array" do
      expect(subject.build_response({ banks: [] })).to be_a(Array)
    end

    let(:data) do
      {
        banks: [
          {id: 1},
          {id: 2}
        ]
      }
    end

    it "returns an Array of SyspaySDK::Entities::AstroPayBank" do
      expect(subject.build_response(data).count).to eq(2)
      expect(subject.build_response(data).first).to be_a(SyspaySDK::Entities::AstroPayBank)
    end
  end
end