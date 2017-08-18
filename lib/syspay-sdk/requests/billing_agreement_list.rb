module SyspaySDK::Requests
  class BillingAgreementList < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/billing-agreements/"

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
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "billing_agreements" data from response') if response[:billing_agreements].nil? or !response[:billing_agreements].is_a?(Array)
      billing_agreements = []

      response[:billing_agreements].each do |billing_agreement_data|
        billing_agreements.push SyspaySDK::Entities::BillingAgreement::build_from_response(billing_agreement_data);
      end
      billing_agreements
    end
  end
end