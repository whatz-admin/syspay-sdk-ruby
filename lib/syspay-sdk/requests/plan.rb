# Get the available banks to process AstroPay payments with.
module SyspaySDK::Requests
  class Plan < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/plan"

    attr_accessor :plan


    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "plan" data from response') if response[:plan].nil?

      SyspaySDK::Entities::Plan::build_from_response(response[:plan]);
    end

    def get_data
      hash = {}
      hash = self.plan.to_hash unless self.plan.nil?
      hash
    end
  end
end