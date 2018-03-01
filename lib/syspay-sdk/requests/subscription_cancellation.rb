module SyspaySDK
  module Requests
    class SubscriptionCancellation < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/subscription/:subscription_id/cancel'.freeze

      attr_accessor :subscription_id

      def initialize(subscription_id = nil)
        self.subscription_id = subscription_id
      end

      def path
        return PATH.gsub(/:subscription_id/, subscription_id) unless subscription_id.nil?
        PATH
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "subscription" data from response' if response[:subscription].nil?

        SyspaySDK::Entities::Subscription.build_from_response(response[:subscription])
      end

      def data
        {
          subscription_id: subscription_id
        }
      end
    end
  end
end
