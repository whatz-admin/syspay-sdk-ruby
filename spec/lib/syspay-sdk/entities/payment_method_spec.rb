describe SyspaySDK::Entities::PaymentMethod do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'payment_method'" do
      expect(described_class::TYPE).to eq('payment_method')
    end

    it "has a TYPE_CREDITCARD class constant set to 'CREDITCARD'" do
      expect(described_class::TYPE_CREDITCARD).to eq('CREDITCARD')
    end

    it "has a TYPE_PAYSAFECARD class constant set to 'PAYSAFECARD'" do
      expect(described_class::TYPE_PAYSAFECARD).to eq('PAYSAFECARD')
    end

    it "has a TYPE_CLICKANDBUY class constant set to 'CLICKANDBUY'" do
      expect(described_class::TYPE_CLICKANDBUY).to eq('CLICKANDBUY')
    end

    it "has a TYPE_POSTFINANCE class constant set to 'POSTFINANCE'" do
      expect(described_class::TYPE_POSTFINANCE).to eq('POSTFINANCE')
    end

    it "has a TYPE_IDEAL class constant set to 'IDEAL'" do
      expect(described_class::TYPE_IDEAL).to eq('IDEAL')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:type) }
    it { is_expected.to respond_to(:display) }
    it { is_expected.to respond_to(:cardholder) }
    it { is_expected.to respond_to(:exp_month) }
    it { is_expected.to respond_to(:exp_year) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      expect {
        described_class.build_from_response({ test: "test" })
      }.to_not raise_error
    end

    it "returns a PaymentMethod object" do
      expect(described_class.build_from_response({ test: "test" })).to be_a(described_class)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        described_class.build_from_response("test")
      }.to raise_error SyspaySDK::Exceptions::BadArgumentTypeError
    end

    let (:response) do
      {
        type: "type",
        display: "display",
        cardholder: 'cardholder',
        exp_month: 'exp_month',
        exp_year: 'exp_year'
      }
    end

    before(:each) do
      @payment_method = described_class.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      expect(@payment_method.raw).to eq(response)
    end

    it "sets instance type attribute using value in response" do
      expect(@payment_method.type).to eq(response[:type])
    end

    it "sets instance display attribute using value in response" do
      expect(@payment_method.display).to eq(response[:display])
    end

    it 'sets instance cardholder attribute using value in response' do
      expect(@payment_method.cardholder).to eq(response[:cardholder])
    end

    it 'sets instance exp_month attribute using value in response' do
      expect(@payment_method.exp_month).to eq(response[:exp_month])
    end

    it 'sets instance exp_year attribute using value in response' do
      expect(@payment_method.exp_year).to eq(response[:exp_year])
    end

  end
end
