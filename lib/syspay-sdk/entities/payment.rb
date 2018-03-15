module SyspaySDK
  module Entities
    class Payment < SyspaySDK::Entities::ReturnedEntity
      attr_accessor :account_id, :amount, :billing_agreement, :chip_and_pin_status, :contract,
                    :currency, :description, :descriptor, :extra, :failure_category, :id,
                    :merchant_id, :merchant_login, :payment_method, :payment_type, :preauth,
                    :processing_time, :recipient_map, :redirect, :reference, :settlement_date,
                    :status, :subscription, :website, :website_url

      TYPE = 'payment'.freeze

      STATUS_OPEN = 'OPEN'.freeze
      STATUS_SUCCESS = 'SUCCESS'.freeze
      STATUS_FAILED = 'FAILED'.freeze
      STATUS_CANCELLED = 'CANCELLED'.freeze
      STATUS_AUTHORIZED = 'AUTHORIZED'.freeze
      STATUS_VOIDED = 'VOIDED'.freeze
      STATUS_WAITING = 'WAITING'.freeze
      STATUS_ERROR = 'ERROR'.freeze

      FAILURE_CARD_FLAGGED = 'card_flagged'.freeze
      FAILURE_DECLINED = 'declined'.freeze
      FAILURE_DUPLICATED = 'duplicated'.freeze
      FAILURE_EXPIRED = 'expired'.freeze
      FAILURE_FRAUD = 'fraud_suspicious'.freeze
      FAILURE_INSUFFICIENT_FUNDS = 'insufficient_funds'.freeze
      FAILURE_INVALID_CARD = 'invalid_card'.freeze
      FAILURE_INVALID_CV2 = 'invalid_cv2'.freeze
      FAILURE_INVALID_DETAILS = 'invalid_details'.freeze
      FAILURE_OTHER = 'other'.freeze
      FAILURE_TECHNICAL_ERROR = 'technical_error'.freeze
      FAILURE_UNSUPPORTED = 'unsupported'.freeze

      TYPE_ONESHOT = 'ONESHOT'.freeze
      TYPE_ONESHOT_RETRY = 'ONESHOT_RETRY'.freeze
      TYPE_BILLING_AGREEMENT_INITIAL = 'BILLING_AGREEMENT_INITIAL'.freeze
      TYPE_BILLING_AGREEMENT_INITIAL_RETRY = 'BILLING_AGREEMENT_INITIAL_RETRY'.freeze
      TYPE_BILLING_AGREEMENT_REBILL = 'BILLING_AGREEMENT_REBILL'.freeze
      TYPE_SUBSCRIPTION_TRIAL = 'SUBSCRIPTION_TRIAL'.freeze
      TYPE_SUBSCRIPTION_INITIAL = 'SUBSCRIPTION_INITIAL'.freeze
      TYPE_SUBSCRIPTION_BILL = 'SUBSCRIPTION_BILL'.freeze
      TYPE_SUBSCRIPTION_MANUAL_REBILL = 'SUBSCRIPTION_MANUAL_REBILL'.freeze

      def assign_attributes(response)
        %i[
          id reference amount currency status extra description
          website failure_category chip_and_pin_status payment_type
          website_url contract descriptor account_id merchant_login merchant_id
        ].each { |attribute| send(:"#{attribute}=", response[attribute]) }

        %i[settlement_date processing_time].each do |attribute|
          unless response[attribute].nil? || response[attribute] == ''
            send(:"#{attribute}=", Time.at(response[attribute].to_i))
          end
        end
      end

      def self.build_billing_agreement(response)
        SyspaySDK::Entities::BillingAgreement.build_from_response(response[:billing_agreement]) unless response[:billing_agreement].nil?
      end

      def self.build_subscription(response)
        SyspaySDK::Entities::Subscription.build_from_response(response[:subscription]) unless response[:subscription].nil?
      end

      def self.build_payment_method(response)
        SyspaySDK::Entities::PaymentMethod.build_from_response(response[:payment_method]) unless response[:payment_method].nil?
      end

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        payment = new
        payment.assign_attributes(response)

        payment.billing_agreement = build_billing_agreement(response)
        payment.subscription = build_subscription(response)
        payment.payment_method = build_payment_method(response)

        payment.raw = response
        payment
      end

      def assign_recipient_map(recipient_map)
        recipient_map.each do |recipient|
          raise SyspaySDK::Exceptions::BadArgumentTypeError, 'assign_recipient_map expects an array of SyspaySDK::Entities::PaymentRecipient' unless recipient.is_a?(SyspaySDK::Entities::PaymentRecipient)
        end

        self.recipient_map = recipient_map
      end

      def add_recipient(recipient)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'add_recipient expects a SyspaySDK::Entities::PaymentRecipient' unless recipient.is_a?(SyspaySDK::Entities::PaymentRecipient)
        self.recipient_map ||= []
        self.recipient_map.push recipient
      end

      def build_recipient_map
        resulting_array = []

        unless recipient_map.nil?
          self.recipient_map.each do |recipient|
            resulting_array.push recipient.to_hash
          end
        end

        resulting_array
      end

      def to_hash
        hash = {}

        %i[reference amount currency description extra preauth].each do |attribute|
          hash[attribute] = send(attribute)
        end

        hash[:recipients] = build_recipient_map
        hash
      end
    end
  end
end
