module SyspaySDK::Requests
  class Confirm < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/payment/:payment_id/confirm"

    attr_accessor :payment_id

    def initialize payment_id = nil
      self.payment_id = payment_id
    end

    def get_path
      return PATH.gsub(/:payment_id/, self.payment_id) unless self.payment_id.nil?
      return PATH
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "payment" data from response') if response[:payment].nil?

      payment = SyspaySDK::Entities::Payment::build_from_response(response[:payment])
      payment.redirect = response[:redirect]

      payment
    end
  end
end