module SyspaySDK::Requests
  class PaymentInfo < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/payment/"

    attr_accessor :payment_id

    def get_path
      "#{PATH}#{self.payment_id}"
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "payment" data from response') if response[:payment].nil?

      payment = SyspaySDK::Entities::Payment::build_from_response(response[:payment])

      payment.redirect = response[:redirect] unless response[:redirect].nil?

      payment
    end


    def get_data
      hash = {}
      hash[:payment_id] = self.payment_id;
      hash
    end
  end
end