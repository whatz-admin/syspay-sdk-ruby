module SyspaySDK::Requests
  class SubscriptionInfo < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/subscription/"

    attr_accessor :subscription_id

    def initialize subscription_id = nil
      self.subscription_id = subscription_id
    end

    def get_path
      "#{PATH}#{self.subscription_id}"
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "subscription" data from response') if response[:subscription].nil?

      subscription = SyspaySDK::Entities::Subscription::build_from_response(response[:subscription])

      subscription.redirect = response[:redirect] unless response[:redirect].nil?

      subscription
    end
  end
end