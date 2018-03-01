module SyspaySDK
  module Requests
    class Rebill < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/billing-agreement/:billing_agreement_id/rebill'.freeze

      attr_accessor :threatmetrix_session_id,
                    :ems_url,
                    :billing_agreement_id,
                    :reference,
                    :amount,
                    :currency,
                    :description,
                    :extra,
                    :recipient_map

      def initialize(billing_agreement_id = nil)
        self.billing_agreement_id = billing_agreement_id
      end

      def path
        return PATH.gsub(/:billing_agreement_id/, billing_agreement_id) unless billing_agreement_id.nil?
        PATH
      end

      def assign_recipient_map(recipient_map)
        recipient_map.each do |recipient|
          unless recipient.is_a?(SyspaySDK::Entities::PaymentRecipient)
            raise SyspaySDK::Exceptions::BadArgumentTypeError,
                  'assign_recipient_map expects an array of SyspaySDK::Entities::PaymentRecipient'
          end
        end

        self.recipient_map = recipient_map
      end

      def add_recipient(recipient)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'add_recipient expects a SyspaySDK::Entities::PaymentRecipient' unless recipient.is_a?(SyspaySDK::Entities::PaymentRecipient)
        self.recipient_map ||= []
        self.recipient_map.push recipient
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "payment" data from response' if response[:payment].nil?

        SyspaySDK::Entities::Payment.build_from_response(response[:payment])
      end

      def data
        hash = {}

        %i[threatmetrix_session_id ems_url].each do |attribute|
          hash[attribute] = send(attribute)
        end

        hash[:payment] = payment_data
        hash[:payment][:recipient_map] = recipient_map_data

        hash
      end

      def payment_data
        hash = {}

        %i[reference amount currency description extra].each do |attribute|
          hash[attribute] = send(attribute)
        end

        hash
      end

      def recipient_map_data
        resulting_array = []

        unless recipient_map.nil?
          self.recipient_map.each do |recipient|
            resulting_array.push recipient.to_hash
          end
        end

        resulting_array
      end
    end
  end
end
