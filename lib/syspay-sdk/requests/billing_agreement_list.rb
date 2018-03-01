module SyspaySDK
  module Requests
    class BillingAgreementList < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/billing-agreements/'.freeze

      attr_accessor :filters

      def initialize
        self.filters = {}
      end

      def add_filter(key, value)
        filters[key] = value
      end

      def delete_filter(key)
        filters.delete(key)
      end

      def data
        filters
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "billing_agreements" data from response' if response[:billing_agreements].nil? || !response[:billing_agreements].is_a?(Array)
        billing_agreements = []

        response[:billing_agreements].each do |billing_agreement_data|
          billing_agreements.push SyspaySDK::Entities::BillingAgreement.build_from_response(billing_agreement_data)
        end
        billing_agreements
      end
    end
  end
end
