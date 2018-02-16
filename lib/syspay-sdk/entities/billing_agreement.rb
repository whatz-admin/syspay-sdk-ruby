module SyspaySDK::Entities
  class BillingAgreement < SyspaySDK::Entities::ReturnedEntity

    TYPE = 'billing_agreement'

    STATUS_PENDING = 'PENDING'
    STATUS_ACTIVE = 'ACTIVE'
    STATUS_CANCELLED = 'CANCELLED'
    STATUS_ENDED = 'ENDED'

    END_REASON_UNSUBSCRIBED_MERCHANT = 'UNSUBSCRIBED_MERCHANT'
    END_REASON_UNSUBSCRIBED_ADMIN = 'UNSUBSCRIBED_ADMIN'
    END_REASON_SUSPENDED_EXPIRED = 'SUSPENDED_EXPIRED'
    END_REASON_SUSPENDED_CHARGEBACK = 'SUSPENDED_CHARGEBACK'

    attr_accessor :id, :status, :currency, :extra, :end_reason, :payment_method, :customer, :expiration_date, :redirect, :description

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)

      billing_agreement = self.new

      billing_agreement.id = response[:id]
      billing_agreement.status = response[:status]
      billing_agreement.currency = response[:currency]
      billing_agreement.extra = response[:extra]
      billing_agreement.end_reason = response[:end_reason]

      billing_agreement.expiration_date = (response[:expiration_date].nil? or response[:expiration_date] == "") ? nil : Time.at(response[:expiration_date].to_i).to_date

      billing_agreement.payment_method = SyspaySDK::Entities::PaymentMethod.build_from_response(response[:payment_method]) unless response[:payment_method].nil?
      billing_agreement.customer = SyspaySDK::Entities::Customer.build_from_response(response[:customer]) unless response[:customer].nil?

      billing_agreement.raw = response
      billing_agreement
    end
  end
end