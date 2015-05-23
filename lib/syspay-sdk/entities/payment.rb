module SyspaySDK::Entities
  class Payment < SyspaySDK::Entities::ReturnedEntity
    TYPE = 'payment'

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

    attr_accessor :account_id,
    :amount,
    :billing_agreement,
    :chip_and_pin_status,
    :contract,
    :currency,
    :description,
    :descriptor,
    :extra,
    :failure_category,
    :id,
    :merchant_id,
    :merchant_login,
    :payment_method,
    :payment_type,
    :preauth,
    :processing_time,
    :recipient_map,
    :redirect,
    :reference,
    :settlement_date,
    :status,
    :subscription,
    :website,
    :website_url

    def self.build_from_response response
      payment = self.new
    end

    def to_hash
      {}
    end
  end
end
