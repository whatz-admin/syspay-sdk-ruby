module SyspaySDK
  module Requests
    class Plan < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/plan'.freeze

      attr_accessor :plan

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "plan" data from response' if response[:plan].nil?

        SyspaySDK::Entities::Plan.build_from_response(response[:plan])
      end

      def data
        hash = {}
        hash = plan.to_hash unless plan.nil?
        hash
      end
    end
  end
end
