module SyspaySDK
  module Requests
    class RefundList < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/refunds/'.freeze

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
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "refunds" data from response' if response[:refunds].nil? || !response[:refunds].is_a?(Array)
        refunds = []

        response[:refunds].each do |refund_data|
          refunds.push SyspaySDK::Entities::Refund.build_from_response(refund_data)
        end
        refunds
      end
    end
  end
end
