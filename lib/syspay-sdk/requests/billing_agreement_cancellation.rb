module SyspaySDK::Requests
  class BillingAgreementCancellation < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/billing-agreement/_ba_id_/cancel"

    attr_accessor :billing_agreement_id

    def initialize billing_agreement_id = nil
      self.billing_agreement_id = billing_agreement_id
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "billing_agreement" data from response') if response[:billing_agreement].nil?

      SyspaySDK::Entities::BillingAgreement::build_from_response(response[:billing_agreement])
    end
  end
end