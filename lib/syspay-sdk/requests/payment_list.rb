module SyspaySDK
  module Requests
    class PaymentList < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/payments/'.freeze

      attr_accessor :filters

      def initialize
        self.filters = {}
      end

      def add_filter(key, value)
        filters[key] = value
      end

      def delete_filter(key)
        filters.delete(key)
      end

      def data
        filters
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "payments" data from response' if response[:payments].nil? || !response[:payments].is_a?(Array)
        payments = []

        response[:payments].each do |payment_data|
          payments.push SyspaySDK::Entities::Payment.build_from_response(payment_data)
        end
        payments
      end
    end
  end
end
