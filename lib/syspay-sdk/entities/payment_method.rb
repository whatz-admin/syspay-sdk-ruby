module SyspaySDK::Entities
  class PaymentMethod < SyspaySDK::Entities::ReturnedEntity
    TYPE = "payment_method"

    TYPE_CREDITCARD = 'CREDITCARD'
    TYPE_PAYSAFECARD = 'PAYSAFECARD'
    TYPE_CLICKANDBUY = 'CLICKANDBUY'
    TYPE_POSTFINANCE = 'POSTFINANCE'
    TYPE_IDEAL = 'IDEAL'

    attr_accessor :type, :display

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)

      payment_method = self.new
      payment_method.type = response[:type]
      payment_method.display = response[:display]

      payment_method.raw = response
      payment_method
    end
  end
end