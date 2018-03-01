module SyspaySDK
  module Entities
    class PaymentMethod < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'payment_method'.freeze

      TYPE_CREDITCARD = 'CREDITCARD'.freeze
      TYPE_PAYSAFECARD = 'PAYSAFECARD'.freeze
      TYPE_CLICKANDBUY = 'CLICKANDBUY'.freeze
      TYPE_POSTFINANCE = 'POSTFINANCE'.freeze
      TYPE_IDEAL = 'IDEAL'.freeze

      attr_accessor :type, :display, :cardholder, :exp_month, :exp_year

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        payment_method = new
        payment_method.type = response[:type]
        payment_method.display = response[:display]
        payment_method.cardholder = response[:cardholder]
        payment_method.exp_month = response[:exp_month]
        payment_method.exp_year = response[:exp_year]

        payment_method.raw = response
        payment_method
      end
    end
  end
end
