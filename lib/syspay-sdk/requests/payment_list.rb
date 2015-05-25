module SyspaySDK::Requests
  class PaymentList < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/payments/"

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
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "payments" data from response') if response[:payments].nil? or !response[:payments].is_a?(Array)
      payments = []

      response[:payments].each do |payment_data|
        payments.push SyspaySDK::Entities::Payment::build_from_response(payment_data);
      end
      payments
    end
  end
end