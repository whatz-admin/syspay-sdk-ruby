module SyspaySDK::Requests
  class RefundList < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/refunds/"

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
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "refunds" data from response') if response[:refunds].nil? or !response[:refunds].is_a?(Array)
      refunds = []

      response[:refunds].each do |refund_data|
        refunds.push SyspaySDK::Entities::Refund::build_from_response(refund_data);
      end
      refunds
    end
  end
end