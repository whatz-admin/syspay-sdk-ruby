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
end
