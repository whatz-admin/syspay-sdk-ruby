require 'spec_helper'

describe SyspaySDK::Entities::CreditCard do
  it "is a SyspaySDK::Entities::BaseClass" do
    subject.should be_a(SyspaySDK::Entities::BaseClass)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'credit_card'" do
      SyspaySDK::Entities::CreditCard::TYPE.should eq('credit_card')
    end
  end

  describe "Attributes" do
    it { should respond_to(:number) }
    it { should respond_to(:cardholder) }
    it { should respond_to(:cvc) }
    it { should respond_to(:exp_month) }
    it { should respond_to(:exp_year) }
    it { should respond_to(:token) }
  end

  it "responds to #to_hash" do
    subject.should respond_to(:to_hash)
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

      subject.to_hash.should include(number: data[:number])
      subject.to_hash.should include(cardholder: data[:cardholder])
      subject.to_hash.should include(cvc: data[:cvc])
      subject.to_hash.should include(exp_month: data[:exp_month])
      subject.to_hash.should include(exp_year: data[:exp_year])
    end

    it "returns the token in a hash when token is present" do
      subject.token = data[:token]

      subject.to_hash.should eq(token: data[:token])
    end
  end
end
# <?php

#     /**
#      * {@inheritDoc}
#      *
#      * If a token is set, use it, otherwise use the full card data
#      */
#     public function toArray()
#     {
#         $data = array();
#         if (true === empty($this->token)) {
#             $data['number']     = $this->number;
#             $data['cardholder'] = $this->cardholder;
#             $data['cvc']        = $this->cvc;
#             $data['exp_month']  = $this->exp_month;
#             $data['exp_year']   = $this->exp_year;
#         } else {
#             $data['token']      = $this->token;
#         }
#         return $data;
#     }
