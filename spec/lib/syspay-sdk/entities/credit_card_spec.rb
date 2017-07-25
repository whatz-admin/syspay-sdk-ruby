describe SyspaySDK::Entities::CreditCard do
  it "is a SyspaySDK::Entities::BaseClass" do
    is_expected.to be_a(SyspaySDK::Entities::BaseClass)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'credit_card'" do
      expect(described_class::TYPE).to eq('credit_card')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:number) }
    it { is_expected.to respond_to(:cardholder) }
    it { is_expected.to respond_to(:cvc) }
    it { is_expected.to respond_to(:exp_month) }
    it { is_expected.to respond_to(:exp_year) }
    it { is_expected.to respond_to(:token) }
  end

  describe "#to_hash" do
    let(:data) do
      {
        number: "number",
        cardholder: "cardholder",
        cvc: "cvc",
        exp_month: "exp_month",
        exp_year: "exp_year",
        token: "token"
      }
    end

    it "returns the credit_card converted to a hash when token is not present" do
      subject.number = data[:number]
      subject.cardholder = data[:cardholder]
      subject.cvc = data[:cvc]
      subject.exp_month = data[:exp_month]
      subject.exp_year = data[:exp_year]

      hash = subject.to_hash

      expect(hash).to include(number: data[:number])
      expect(hash).to include(cardholder: data[:cardholder])
      expect(hash).to include(cvc: data[:cvc])
      expect(hash).to include(exp_month: data[:exp_month])
      expect(hash).to include(exp_year: data[:exp_year])
    end

    it "returns the token in a hash when token is present" do
      subject.token = data[:token]

      expect(subject.to_hash).to eq(token: data[:token])
    end
  end
end
