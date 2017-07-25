describe SyspaySDK::Entities::PaymentRecipient do
  it "is a SyspaySDK::Entities::BaseClass" do
    is_expected.to be_a(SyspaySDK::Entities::BaseClass)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'payment_recipient'" do
      expect(described_class::TYPE).to eq('payment_recipient')
    end

    it "has a CALC_TYPE_FIXED class constant set to 'fixed'" do
      expect(described_class::CALC_TYPE_FIXED).to eq('fixed')
    end

    it "has a CALC_TYPE_PERCENT class constant set to 'percent'" do
      expect(described_class::CALC_TYPE_PERCENT).to eq('percent')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:account_id) }
    it { is_expected.to respond_to(:calc_type) }
    it { is_expected.to respond_to(:value) }
    it { is_expected.to respond_to(:currency) }
    it { is_expected.to respond_to(:settlement_delay) }
  end

  describe "#to_hash" do
    it "returns the PaymentRecipient converted to a hash" do
      recipient = described_class.new

      params = {
        user_id: 1,
        account_id: 1,
        calc_type: described_class::CALC_TYPE_FIXED,
        value: 1,
        currency: "EUR",
        settlement_delay: 1
      }

      recipient.user_id = params[:user_id]
      recipient.account_id = params[:account_id]
      recipient.calc_type = params[:calc_type]
      recipient.value = params[:value]
      recipient.currency = params[:currency]
      recipient.settlement_delay = params[:settlement_delay]

      hash = recipient.to_hash

      expect(hash).to include(user_id: params[:user_id])
      expect(hash).to include(account_id: params[:account_id])
      expect(hash).to include(calc_type: params[:calc_type])
      expect(hash).to include(value: params[:value])
      expect(hash).to include(currency: params[:currency])
      expect(hash).to include(settlement_delay: params[:settlement_delay])
    end
  end
end
