module SyspaySDK
  module Requests
    class ChargebackInfo < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/chargeback/'.freeze

      attr_accessor :chargeback_id

      def initialize(chargeback_id = nil)
        self.chargeback_id = chargeback_id
      end

      def path
        "#{PATH}#{chargeback_id}"
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "chargeback" data from response' if response[:chargeback].nil?

        SyspaySDK::Entities::Chargeback.build_from_response(response[:chargeback])
      end
    end
  end
end
