require 'spec_helper'

describe SyspaySDK::Entities::PaymentRecipient do
  it "is a SyspaySDK::Entities::BaseClass" do
    subject.should be_a(SyspaySDK::Entities::BaseClass)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'payment_recipient'" do
      SyspaySDK::Entities::PaymentRecipient::TYPE.should eq('payment_recipient')
    end

    it "has a CALC_TYPE_FIXED class constant set to 'fixed'" do
      SyspaySDK::Entities::PaymentRecipient::CALC_TYPE_FIXED.should eq('fixed')
    end

    it "has a CALC_TYPE_PERCENT class constant set to 'percent'" do
      SyspaySDK::Entities::PaymentRecipient::CALC_TYPE_PERCENT.should eq('percent')
    end
  end

  describe "Attributes" do
    it { should respond_to(:user_id) }
    it { should respond_to(:account_id) }
    it { should respond_to(:calc_type) }
    it { should respond_to(:value) }
    it { should respond_to(:currency) }
    it { should respond_to(:settlement_delay) }
  end

  it "responds to #to_hash" do
    subject.should respond_to(:to_hash)
  end

  describe "#to_hash" do
    it "returns the PaymentRecipient converted to a hash" do
      recipient = SyspaySDK::Entities::PaymentRecipient.new
      params = {
        user_id: 1,
        account_id: 1,
        calc_type: SyspaySDK::Entities::PaymentRecipient::CALC_TYPE_FIXED,
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

      recipient.to_hash.should include(user_id: params[:user_id])
      recipient.to_hash.should include(account_id: params[:account_id])
      recipient.to_hash.should include(calc_type: params[:calc_type])
      recipient.to_hash.should include(value: params[:value])
      recipient.to_hash.should include(currency: params[:currency])
      recipient.to_hash.should include(settlement_delay: params[:settlement_delay])
    end
  end
end
