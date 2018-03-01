module SyspaySDK
  module Requests
    class RefundInfo < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/refund/'.freeze

      attr_accessor :refund_id

      def initialize(refund_id = nil)
        self.refund_id = refund_id
      end

      def path
        "#{PATH}#{refund_id}"
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "refund" data from response' if response[:refund].nil?

        SyspaySDK::Entities::Refund.build_from_response(response[:refund])
      end
    end
  end
end
