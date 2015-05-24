module SyspaySDK::Requests
  class Eterminal < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/eterminal"

    TYPE_ONESHOT = 'ONESHOT'
    TYPE_SUBSCRIPTION = 'SUBSCRIPTION'
    TYPE_PAYMENT_PLAN = 'PAYMENT_PLAN'
    TYPE_PAYMENT_MANDATE = 'PAYMENT_MANDATE'
    attr_accessor :website,
    :locked,
    :ems_url,
    :payment_redirect_url,
    :eterminal_redirect_url,
    :type,
    :description,
    :reference,
    :customer,
    :oneshot,
    :subscription,
    :payment_plan,
    :payment_mandate,
    :allowed_retries

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "eterminal" data from response') if response[:eterminal].nil?

      SyspaySDK::Entities::Eterminal::build_from_response(response[:eterminal]);
    end

    def get_data
      hash = {}
      hash[:locked] = (self.locked.nil? or self.locked == false) ? false : true
      hash[:type] = self.type
      hash[:website] = self.website
      hash[:website] = self.website
      hash[:ems_url] = self.ems_url
      hash[:payment_redirect_url] = self.payment_redirect_url
      hash[:eterminal_redirect_url] = self.eterminal_redirect_url
      hash[:description] = self.description
      hash[:reference] = self.reference
      hash[:customer] = self.customer
      hash[:oneshot] = self.oneshot
      hash[:subscription] = self.subscription
      hash[:payment_plan] = self.payment_plan
      hash[:payment_mandate] = self.payment_mandate
      hash[:allowed_retries] = self.allowed_retries
      hash
    end
  end
end