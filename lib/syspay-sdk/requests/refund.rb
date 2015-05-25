module SyspaySDK::Requests
  class Refund < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/refund"

    attr_accessor :payment_id, :ems_url, :refund

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "refund" data from response') if response[:refund].nil?

      SyspaySDK::Entities::Refund::build_from_response(response[:refund]);
    end

    def get_data
      hash = {}
      hash = self.refund.to_hash unless self.refund.nil?
      hash[:payment_id] = self.payment_id
      hash[:ems_url] = self.ems_url unless self.ems_url.nil?
      hash
    end
  end
end