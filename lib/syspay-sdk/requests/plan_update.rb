module SyspaySDK
  module Requests
    class PlanUpdate < SyspaySDK::Requests::BaseClass
      METHOD = 'PUT'.freeze
      PATH = '/api/v1/merchant/plan/'.freeze

      attr_accessor :plan_id, :trial_amount, :initial_amount, :billing_amount

      def initialize(plan_id = nil)
        self.plan_id = plan_id
      end

      def path
        "#{PATH}#{plan_id}"
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "plan" data from response' if response[:plan].nil?

        SyspaySDK::Entities::Plan.build_from_response(response[:plan])
      end

      def data
        hash = {}
        hash[:plan_id] = plan_id
        hash[:trial_amount] = trial_amount
        hash[:initial_amount] = initial_amount
        hash[:billing_amount] = billing_amount
        hash
      end
    end
  end
end
