module SyspaySDK::Requests
  class PlanUpdate < SyspaySDK::Requests::BaseClass
    METHOD = "PUT"
    PATH = "/api/v1/merchant/plan/"

    attr_accessor :plan_id, :trial_amount, :initial_amount, :billing_amount

    def initialize plan_id = nil
      self.plan_id = plan_id
    end

    def get_path
      "#{PATH}#{self.plan_id}"
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "plan" data from response') if response[:plan].nil?

      SyspaySDK::Entities::Plan::build_from_response(response[:plan])
    end

    def get_data
      hash = {}
      hash[:plan_id] = self.plan_id
      hash[:trial_amount] = self.trial_amount
      hash[:initial_amount] = self.initial_amount
      hash[:billing_amount] = self.billing_amount
      hash
    end
  end
end