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

    STATUS_OPEN = 'OPEN'
    STATUS_SUCCESS = 'SUCCESS'
    STATUS_FAILED = 'FAILED'
    STATUS_CANCELLED = 'CANCELLED'
    STATUS_AUTHORIZED = 'AUTHORIZED'
    STATUS_VOIDED = 'VOIDED'
    STATUS_WAITING = 'WAITING'
    STATUS_ERROR = 'ERROR'

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

    TYPE_ONESHOT = 'ONESHOT'
    TYPE_ONESHOT_RETRY = 'ONESHOT_RETRY'
    TYPE_BILLING_AGREEMENT_INITIAL = 'BILLING_AGREEMENT_INITIAL'
    TYPE_BILLING_AGREEMENT_INITIAL_RETRY = 'BILLING_AGREEMENT_INITIAL_RETRY'
    TYPE_BILLING_AGREEMENT_REBILL = 'BILLING_AGREEMENT_REBILL'
    TYPE_SUBSCRIPTION_TRIAL = 'SUBSCRIPTION_TRIAL'
    TYPE_SUBSCRIPTION_INITIAL = 'SUBSCRIPTION_INITIAL'
    TYPE_SUBSCRIPTION_BILL = 'SUBSCRIPTION_BILL'
    TYPE_SUBSCRIPTION_MANUAL_REBILL = 'SUBSCRIPTION_MANUAL_REBILL'

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

      payment.settlement_date = (response[:settlement_date].nil? or response[:settlement_date] == "") ? nil : Time.at(response[:settlement_date].to_i).to_date
      payment.processing_time = (response[:processing_time].nil? or response[:processing_time] == "") ? nil : Time.at(response[:processing_time].to_i).to_date


      payment.billing_agreement = SyspaySDK::Entities::BillingAgreement.build_from_response(response[:billing_agreement]) unless response[:billing_agreement].nil?
      payment.subscription = SyspaySDK::Entities::Subscription.build_from_response(response[:subscription]) unless response[:subscription].nil?
      payment.payment_method = SyspaySDK::Entities::PaymentMethod.build_from_response(response[:payment_method]) unless response[:payment_method].nil?

      payment.raw = response
      payment
    end

    def set_recipient_map recipient_map
      recipient_map.each do |recipient|
        raise SyspaySDK::Exceptions::BadArgumentTypeError.new('set_recipient_map expects an array of SyspaySDK::Entities::PaymentRecipient') unless recipient.is_a?(SyspaySDK::Entities::PaymentRecipient)
      end
      self.recipient_map = recipient_map
    end

    def add_recipient recipient
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new('add_recipient expects a SyspaySDK::Entities::PaymentRecipient') unless recipient.is_a?(SyspaySDK::Entities::PaymentRecipient)
      self.recipient_map ||= []
      self.recipient_map.push recipient
    end

    def to_hash
      hash = {}

      [:reference, :amount, :currency, :description, :extra, :preauth ].each do |attribute|
        hash[attribute] = self.send(attribute)
      end

      hash[:recipients] = []
      self.recipient_map.each do |recipient|
        hash[:recipients].push recipient.to_hash
      end unless recipient_map.nil?

      hash
    end
  end
end
