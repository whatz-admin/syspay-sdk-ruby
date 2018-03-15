module SyspaySDK
  module Entities
    class BillingAgreement < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'billing_agreement'.freeze

      STATUS_PENDING = 'PENDING'.freeze
      STATUS_ACTIVE = 'ACTIVE'.freeze
      STATUS_CANCELLED = 'CANCELLED'.freeze
      STATUS_ENDED = 'ENDED'.freeze

      END_REASON_UNSUBSCRIBED_MERCHANT = 'UNSUBSCRIBED_MERCHANT'.freeze
      END_REASON_UNSUBSCRIBED_ADMIN = 'UNSUBSCRIBED_ADMIN'.freeze
      END_REASON_SUSPENDED_EXPIRED = 'SUSPENDED_EXPIRED'.freeze
      END_REASON_SUSPENDED_CHARGEBACK = 'SUSPENDED_CHARGEBACK'.freeze

      attr_accessor :id,
                    :status,
                    :currency,
                    :extra,
                    :end_reason,
                    :payment_method,
                    :customer,
                    :expiration_date,
                    :redirect,
                    :description

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        billing_agreement = new

        %i[id status currency extra end_reason].each do |attribute|
          billing_agreement.send(:"#{attribute}=", response[attribute])
        end

        billing_agreement.expiration_date = build_expiration_date(response)
        billing_agreement.payment_method = build_payment_method(response)
        billing_agreement.customer = build_customer(response)

        billing_agreement.raw = response
        billing_agreement
      end

      def self.build_expiration_date(response)
        Time.at(response[:expiration_date].to_i) unless response[:expiration_date].nil? || (response[:expiration_date] == '')
      end

      def self.build_payment_method(response)
        SyspaySDK::Entities::PaymentMethod.build_from_response(response[:payment_method]) unless response[:payment_method].nil?
      end

      def self.build_customer(response)
        SyspaySDK::Entities::Customer.build_from_response(response[:customer]) unless response[:customer].nil?
      end
    end
  end
end
