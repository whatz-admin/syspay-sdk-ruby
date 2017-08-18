module SyspaySDK::Requests
  class PlanInfo < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/plan/"

    attr_accessor :plan_id

    def initialize plan_id = nil
      self.plan_id = plan_id
    end

    def get_path
      "#{PATH}#{plan_id}"
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "plan" data from response') if response[:plan].nil?

      SyspaySDK::Entities::Plan::build_from_response(response[:plan])
    end

    def get_data
      {
        plan_id: plan_id
      }
     end
  end
end