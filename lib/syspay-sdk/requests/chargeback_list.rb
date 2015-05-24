module SyspaySDK::Requests
  class ChargebackList < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/chargebacks"

    attr_accessor :filters

    def initialize
      self.filters = {}
    end

    def add_filter key, value
      self.filters[key] = value
    end

    def delete_filter key
      filters.delete(key)
    end

    def get_data
      filters
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "chargebacks" data from response') if response[:chargebacks].nil? or !response[:chargebacks].is_a?(Array)
      chargebacks = []

      response[:chargebacks].each do |chargeback_data|
        chargebacks.push SyspaySDK::Entities::Chargeback::build_from_response(chargeback_data);
      end
      chargebacks
    end
  end
end