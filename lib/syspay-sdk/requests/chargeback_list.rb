module SyspaySDK
  module Requests
    class ChargebackList < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/chargebacks'.freeze

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
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "chargebacks" data from response' if response[:chargebacks].nil? || !response[:chargebacks].is_a?(Array)
        chargebacks = []

        response[:chargebacks].each do |chargeback_data|
          chargebacks.push SyspaySDK::Entities::Chargeback.build_from_response(chargeback_data)
        end
        chargebacks
      end
    end
  end
end
