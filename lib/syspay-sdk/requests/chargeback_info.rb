module SyspaySDK::Requests
  class ChargebackInfo < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/chargeback/"

    attr_accessor :chargeback_id

    def initialize chargeback_id = nil
      self.chargeback_id = chargeback_id
    end

    def get_path
      "#{PATH}#{self.chargeback_id}"
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "chargeback" data from response') if response[:chargeback].nil?

      SyspaySDK::Entities::Chargeback::build_from_response(response[:chargeback])
    end
  end
end