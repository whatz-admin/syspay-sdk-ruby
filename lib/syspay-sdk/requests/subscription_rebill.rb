module SyspaySDK::Requests
  class SubscriptionRebill < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/subscription/:subscription_id/rebill"

    attr_accessor :subscription_id,
    :reference,
    :amount,
    :currency,
    :description,
    :ems_url,
    :extra

    def initialize subscription_id = nil
      self.subscription_id = subscription_id
    end

    def get_path
      return PATH.gsub(/:subscription_id/, self.subscription_id) unless self.subscription_id.nil?
      return PATH
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "payment" data from response') if response[:payment].nil?

      SyspaySDK::Entities::Payment::build_from_response(response[:payment]);
    end

    def get_data
      hash = {}

      [ :subscription_id, :reference, :amount, :currency, :description, :ems_url, :extra ].each do |attribute|
        hash[attribute] = self.send(attribute)
      end

      hash
    end
  end
end