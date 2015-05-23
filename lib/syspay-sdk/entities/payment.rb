module SyspaySDK::Entities
  class Payment
    include SyspaySDK::Entities::ReturnedEntity

    FAILURE_CARD_FLAGGED = 'card_flagged'
    FAILURE_DECLINED = 'declined'
    FAILURE_DUPLICATED = 'duplicated'
    FAILURE_EXPIRED = 'expired'
    FAILURE_FRAUD = 'fraud_suspicious'
    FAILURE_INSUFFICIENT_FUNDS = 'insufficient_funds'
    FAILURE_INVALID_CARD = 'invalid_card'
    FAILURE_INVALID_CV2 = 'invalid_cv2'
    FAILURE_INVALID_DETAILS = 'invalid_details'
    FAILURE_OTHER = 'other'
    FAILURE_TECHNICAL_ERROR = 'technical_error'
    FAILURE_UNSUPPORTED = 'unsupported'

    attr_accessor :id,
    :status,
    :chip_and_pin_status,
    :failure_category,
    :reference,
    :amount,
    :currency,
    :description,
    :extra,
    :preauth,
    :website,
    :billing_agreement,
    :subscription,
    :redirect,
    :processing_time,
    :recipient_map,
    :payment_type,
    :website_url,
    :contract,
    :descriptor,
    :account_id,
    :merchant_login,
    :merchant_id,
    :settlement_date,
    :payment_method

    def self.build_from_response response
      payment = self.new
    end
  end
end
