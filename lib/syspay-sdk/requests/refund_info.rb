module SyspaySDK::Requests
  class RefundInfo < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/refund/"

    attr_accessor :refund_id

    def initialize refund_id = nil
      self.refund_id = refund_id
    end

    def get_path
      "#{PATH}#{self.refund_id}"
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "refund" data from response') if response[:refund].nil?

      SyspaySDK::Entities::Refund::build_from_response(response[:refund])
    end
  end
end