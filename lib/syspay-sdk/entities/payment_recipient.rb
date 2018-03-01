module SyspaySDK
  module Entities
    class PaymentRecipient < SyspaySDK::Entities::BaseClass
      TYPE = 'payment_recipient'.freeze

      CALC_TYPE_FIXED = 'fixed'.freeze
      CALC_TYPE_PERCENT = 'percent'.freeze

      attr_accessor :user_id, :account_id, :calc_type, :value, :currency, :settlement_delay

      def to_hash
        hash = {}

        %i[user_id account_id calc_type value currency settlement_delay].each do |attribute|
          hash[attribute] = send(attribute)
        end

        hash
      end
    end
  end
end
