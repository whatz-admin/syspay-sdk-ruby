module SyspaySDK
  module Requests
    class Confirm < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/payment/:payment_id/confirm'.freeze

      attr_accessor :payment_id

      def initialize(payment_id = nil)
        self.payment_id = payment_id
      end

      def path
        return PATH.gsub(/:payment_id/, payment_id) unless payment_id.nil?
        PATH
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "payment" data from response' if response[:payment].nil?

        payment = SyspaySDK::Entities::Payment.build_from_response(response[:payment])
        payment.redirect = response[:redirect]

        payment
      end
    end
  end
end
