module SyspaySDK
  module Requests
    class Subscription < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/subscription'.freeze

      FLOW_API = 'API'.freeze
      FLOW_BUYER = 'BUYER'.freeze
      FLOW_SELLER = 'SELLER'.freeze

      attr_accessor :flow,
                    :subscription,
                    :customer,
                    :method,
                    :threatmetrix_session_id,
                    :creditcard,
                    :use_subscription,
                    :use_billing_agreement

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "subscription" data from response' if response[:subscription].nil?

        subscription = SyspaySDK::Entities::Subscription.build_from_response(response[:subscription])

        subscription.redirect = response[:redirect] unless response[:redirect].nil?
        subscription
      end

      def data
        hash = {}

        %i[flow method threatmetrix_session_id use_subscription use_billing_agreement].each do |attribute|
          hash[attribute] = send(attribute)
        end

        %i[creditcard customer subscription].each do |entity|
          hash[entity] = send(entity).to_hash unless send(entity).nil?
        end

        hash
      end
    end
  end
end
