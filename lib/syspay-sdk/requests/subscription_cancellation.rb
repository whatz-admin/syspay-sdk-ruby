module SyspaySDK::Requests
  class SubscriptionCancellation < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/subscription/:subscription_id/cancel"

    attr_accessor :subscription_id

    def initialize subscription_id = nil
      self.subscription_id = subscription_id
    end

    def get_path
      return PATH.gsub(/:subscription_id/, self.subscription_id) unless self.subscription_id.nil?
      return PATH
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "subscription" data from response') if response[:subscription].nil?

      SyspaySDK::Entities::Subscription::build_from_response(response[:subscription])
    end

    def get_data
      {
        subscription_id: self.subscription_id
      }
    end
  end
end