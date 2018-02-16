describe SyspaySDK::Entities::AstroPayBank do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:logo_url) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      expect {
        described_class.build_from_response({ test: "test" })
      }.to_not raise_error
    end

    it "returns a AstroPayBank object" do
      expect(described_class.build_from_response({ test: "test" })).to be_a(described_class)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        described_class.build_from_response("test")
      }.to raise_error SyspaySDK::Exceptions::BadArgumentTypeError
    end

    let (:response) do
      {
        code: "code",
        name: "name",
        logo_url: "url"
      }
    end

    before(:each) do
      @astro_pay_bank = described_class.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      expect(@astro_pay_bank.raw).to eq(response)
    end

    it "sets instance code attribute using value in response" do
      expect(@astro_pay_bank.code).to eq(response[:code])
    end

    it "sets instance name attribute using value in response" do
      expect(@astro_pay_bank.name).to eq(response[:name])
    end

    it "sets instance logo_url attribute using value in response" do
      expect(@astro_pay_bank.logo_url).to eq(response[:logo_url])
    end
  end
end