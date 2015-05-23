module SyspaySDK::Entities
  class Payment < SyspaySDK::Entities::ReturnedEntity

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

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      payment = self.new
      payment.id = response[:id]
      payment.reference = response[:reference]
      payment.amount = response[:amount]
      payment.currency = response[:currency]
      payment.status = response[:status]
      payment.extra = response[:extra]
      payment.description = response[:description]
      payment.website = response[:website]
      payment.failure_category = response[:failure_category]
      payment.chip_and_pin_status = response[:chip_and_pin_status]
      payment.payment_type = response[:payment_type]
      payment.website_url = response[:website_url]
      payment.contract = response[:contract]
      payment.descriptor = response[:descriptor]
      payment.account_id = response[:account_id]
      payment.merchant_login = response[:merchant_login]
      payment.merchant_id = response[:merchant_id]

      payment.settlement_date = (response[:settlement_date].nil? or response[:settlement_date] == "") ? nil : Time.at(response[:settlement_date]).to_date
      payment.processing_time = (response[:processing_time].nil? or response[:processing_time] == "") ? nil : Time.at(response[:processing_time]).to_date

      payment.billing_agreement = response[:billing_agreement]
      payment.subscription = response[:subscription]
      payment.payment_method = response[:payment_method]

      payment.raw = response
      payment
    end

    def set_recipient_map
    end

    def add_recipient
    end

    def to_hash
      {}
    end
  end
end
