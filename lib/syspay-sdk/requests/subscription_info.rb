module SyspaySDK
  module Requests
    class SubscriptionInfo < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/subscription/'.freeze

      attr_accessor :subscription_id

      def initialize(subscription_id = nil)
        self.subscription_id = subscription_id
      end

      def path
        "#{PATH}#{subscription_id}"
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "subscription" data from response' if response[:subscription].nil?

        subscription = SyspaySDK::Entities::Subscription.build_from_response(response[:subscription])

        subscription.redirect = response[:redirect] unless response[:redirect].nil?

        subscription
      end
    end
  end
end
