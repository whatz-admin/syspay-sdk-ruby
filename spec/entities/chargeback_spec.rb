require 'spec_helper'

describe SyspaySDK::Entities::Chargeback do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'chargeback'" do
      SyspaySDK::Entities::Chargeback::TYPE.should eq('chargeback')
    end
  end

  describe "Attributes" do
    it { should respond_to(:id) }
    it { should respond_to(:status) }
    it { should respond_to(:amount) }
    it { should respond_to(:currency) }
    it { should respond_to(:reason_code) }
    it { should respond_to(:payment) }
    it { should respond_to(:processing_time) }
    it { should respond_to(:bank_time) }
  end

  it "responds to ::build_from_response" do
    SyspaySDK::Entities::Chargeback.should respond_to(:build_from_response)
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::Chargeback.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a Chargeback object" do
      SyspaySDK::Entities::Chargeback.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::Chargeback)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::Chargeback.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      {
        id: "id",
        status: "status",
        amount: "amount",
        currency: "currency",
        reason_code: "reason_code"
      }
    end

    before(:each) do
      @billing_agreement = SyspaySDK::Entities::Chargeback.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @billing_agreement.raw.should eq(response)
    end

    it "sets instance id attribute using value in response" do
      @billing_agreement.id.should eq(response[:id])
    end

    it "sets instance status attribute using value in response" do
      @billing_agreement.status.should eq(response[:status])
    end

    it "sets instance amount attribute using value in response" do
      @billing_agreement.amount.should eq(response[:amount])
    end

    it "sets instance currency attribute using value in response" do
      @billing_agreement.currency.should eq(response[:currency])
    end

    it "sets instance reason_code attribute using value in response" do
      @billing_agreement.reason_code.should eq(response[:reason_code])
    end

    it "sets instance processing_time attribute using value in response" do
      processing_time = DateTime.new(2001,2,3)
      response[:processing_time] = processing_time.to_time.to_i
      SyspaySDK::Entities::Chargeback.build_from_response(response).processing_time.should eq(processing_time)
    end

    it "sets instance bank_time attribute using value in response" do
      bank_time = DateTime.new(2001,2,3)
      response[:bank_time] = bank_time.to_time.to_i
      SyspaySDK::Entities::Chargeback.build_from_response(response).bank_time.should eq(bank_time)
    end

    it "sets instance payment attribute using value in response"
  end
end

# <?php

#     private $payment;
#     private $processingTime;
#     private $bankTime;

#     /**
#      * Build a payment entity based on a json-decoded payment stdClass
#      *
#      * @param  stdClass $response The payment data
#      * @return Syspay_Merchant_Entity_Payment The payment object
#      */
#     public static function buildFromResponse(stdClass $response)
#     {
#         if (isset($response->payment)) {
#             $chargeback->setPayment(Syspay_Merchant_Entity_Payment::buildFromResponse($response->payment));
#         }
#         $chargeback-raw = $response;
#         return $chargeback;
#     }
