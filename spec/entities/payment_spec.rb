require 'spec_helper'

describe SyspaySDK::Entities::Payment do
  describe "Failure constants" do
    it "has a FAILURE_CARD_FLAGGED class constant set to 'card_flagged'" do
      SyspaySDK::Entities::Payment::FAILURE_CARD_FLAGGED.should eq('card_flagged')
    end

    it "has a FAILURE_DECLINED class constant set to 'declined'" do
      SyspaySDK::Entities::Payment::FAILURE_DECLINED.should eq('declined')
    end

    it "has a FAILURE_DUPLICATED class constant set to 'duplicated'" do
      SyspaySDK::Entities::Payment::FAILURE_DUPLICATED.should eq('duplicated')
    end

    it "has a FAILURE_EXPIRED class constant set to 'expired'" do
      SyspaySDK::Entities::Payment::FAILURE_EXPIRED.should eq('expired')
    end

    it "has a FAILURE_FRAUD class constant set to 'fraud_suspicious'" do
      SyspaySDK::Entities::Payment::FAILURE_FRAUD.should eq('fraud_suspicious')
    end

    it "has a FAILURE_INSUFFICIENT_FUNDS class constant set to 'insufficient_funds'" do
      SyspaySDK::Entities::Payment::FAILURE_INSUFFICIENT_FUNDS.should eq('insufficient_funds')
    end

    it "has a FAILURE_INVALID_CARD class constant set to 'invalid_card'" do
      SyspaySDK::Entities::Payment::FAILURE_INVALID_CARD.should eq('invalid_card')
    end

    it "has a FAILURE_INVALID_CV2 class constant set to 'invalid_cv2'" do
      SyspaySDK::Entities::Payment::FAILURE_INVALID_CV2.should eq('invalid_cv2')
    end

    it "has a FAILURE_INVALID_DETAILS class constant set to 'invalid_details'" do
      SyspaySDK::Entities::Payment::FAILURE_INVALID_DETAILS.should eq('invalid_details')
    end

    it "has a FAILURE_OTHER class constant set to 'other'" do
      SyspaySDK::Entities::Payment::FAILURE_OTHER.should eq('other')
    end

    it "has a FAILURE_TECHNICAL_ERROR class constant set to 'technical_error'" do
      SyspaySDK::Entities::Payment::FAILURE_TECHNICAL_ERROR.should eq('technical_error')
    end

    it "has a FAILURE_UNSUPPORTED class constant set to 'unsupported'" do
      SyspaySDK::Entities::Payment::FAILURE_UNSUPPORTED.should eq('unsupported')
    end
  end

  describe "Attributes" do
    it { should respond_to(:id) }
    it { should respond_to(:status) }
    it { should respond_to(:chip_and_pin_status) }
    it { should respond_to(:failure_category) }
    it { should respond_to(:reference) }
    it { should respond_to(:amount) }
    it { should respond_to(:currency) }
    it { should respond_to(:description) }
    it { should respond_to(:extra) }
    it { should respond_to(:preauth) }
    it { should respond_to(:website) }
    it { should respond_to(:billing_agreement) }
    it { should respond_to(:subscription) }
    it { should respond_to(:redirect) }
    it { should respond_to(:processing_time) }
    it { should respond_to(:recipient_map) }
    it { should respond_to(:payment_type) }
    it { should respond_to(:website_url) }
    it { should respond_to(:contract) }
    it { should respond_to(:descriptor) }
    it { should respond_to(:account_id) }
    it { should respond_to(:merchant_login) }
    it { should respond_to(:merchant_id) }
    it { should respond_to(:settlement_date) }
    it { should respond_to(:payment_method) }
  end

  it "responds to ::build_from_response" do
    SyspaySDK::Entities::Payment.should respond_to(:build_from_response)
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::Payment.build_from_response "test"
      end.should_not raise_error
    end

    it "returns a Payment object" do
      SyspaySDK::Entities::Payment.build_from_response("test").should be_a(SyspaySDK::Entities::Payment)
    end
  end
end

#     public static function buildFromResponse(stdClass $response)
#     {
#         $payment = new self();
#         $payment->setId(isset($response->id)?$response->id:null);
#         $payment->setReference(isset($response->reference)?$response->reference:null);
#         $payment->setAmount(isset($response->amount)?$response->amount:null);
#         $payment->setCurrency(isset($response->currency)?$response->currency:null);
#         $payment->setStatus(isset($response->status)?$response->status:null);
#         $payment->setExtra(isset($response->extra)?$response->extra:null);
#         $payment->setDescription(isset($response->description)?$response->description:null);
#         $payment->setWebsite(isset($response->website)?$response->website:null);
#         $payment->setFailureCategory(isset($response->failure_category)?$response->failure_category:null);
#         $payment->setChipAndPinStatus(isset($response->chip_and_pin_status)?$response->chip_and_pin_status:null);
#         $payment->setPaymentType(isset($response->payment_type)?$response->payment_type:null);
#         $payment->setWebsiteUrl(isset($response->website_url)?$response->website_url:null);
#         $payment->setContract(isset($response->contract)?$response->contract:null);
#         $payment->setDescriptor(isset($response->descriptor)?$response->descriptor:null);
#         $payment->setAccountId(isset($response->account_id)?$response->account_id:null);
#         $payment->setMerchantLogin(isset($response->merchant_login)?$response->merchant_login:null);
#         $payment->setMerchantId(isset($response->merchant_id)?$response->merchant_id:null);
#         if (isset($response->settlement_date)
#                 && !is_null($response->settlement_date)) {
#             $payment->setSettlementDate(Syspay_Merchant_Utils::tsToDateTime($response->settlement_date));
#         }
#         if (isset($response->processing_time)
#                 && !is_null($response->processing_time)) {
#             $payment->setProcessingTime(Syspay_Merchant_Utils::tsToDateTime($response->processing_time));
#         }
#         if (isset($response->billing_agreement)
#                 && ($response->billing_agreement instanceof stdClass)) {
#             $billingAgreement =
#                 Syspay_Merchant_Entity_BillingAgreement::buildFromResponse($response->billing_agreement);
#             $payment->setBillingAgreement($billingAgreement);
#         }
#         if (isset($response->subscription)
#                 && ($response->subscription instanceof stdClass)) {
#             $subscription = Syspay_Merchant_Entity_Subscription::buildFromResponse($response->subscription);
#             $payment->setSubscription($subscription);
#         }
#         if (isset($response->payment_method)
#                 && ($response->payment_method instanceof stdClass)) {
#             $paymentMethod = Syspay_Merchant_Entity_PaymentMethod::buildFromResponse($response->payment_method);
#             $payment->setPaymentMethod($paymentMethod);
#         }
#         $payment->raw = $response;
#         return $payment;
#     }


#     /**
#      * Sets the value of recipient_map.
#      *
#      * @param array $recipientMap An array of Syspay_Merchant_Entity_PaymentRecipient
#      *
#      * @return self
#      */
#     public function setRecipientMap(array $recipientMap)
#     {
#         foreach ($recipientMap as $r) {
#             if (!$r instanceof Syspay_Merchant_Entity_PaymentRecipient) {
#                 throw new InvalidArgumentException(
#                     'The given array must only contain Syspay_Merchant_Entity_PaymentRecipient instances'
#                 );
#             }
#         }
#         $this->recipient_map = $recipientMap;
#         return $this;
#     }

#     /**
#      * Add a PaymentRecipient to the recipient map list
#      *
#      * @param Syspay_Merchant_Entity_PaymentRecipient $paymentRecipient
#      *
#      * @return self
#      */
#     public function addRecipient(Syspay_Merchant_Entity_PaymentRecipient $paymentRecipient)
#     {
#         if (!isset($this->recipient_map)) {
#             $this->recipient_map = array();
#         }
#         array_push($this->recipient_map, $paymentRecipient);
#     }

#     /**
#      * {@inheritDoc}
#      */
#     public function toArray()
#     {
#         $data = parent::toArray();
#         if (!empty($data['recipient_map']) && is_array($data['recipient_map'])) {
#             for ($i = 0; $i < count($data['recipient_map']); $i++) {
#                 $data['recipient_map'][$i] = $data['recipient_map'][$i]->toArray();
#             }
#         } else {
#             unset($data['recipient_map']);
#         }
#         return $data;
#     }
