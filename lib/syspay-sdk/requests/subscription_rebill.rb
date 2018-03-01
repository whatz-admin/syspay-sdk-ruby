module SyspaySDK
  module Requests
    class SubscriptionRebill < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/subscription/:subscription_id/rebill'.freeze

      attr_accessor :subscription_id,
                    :reference,
                    :amount,
                    :currency,
                    :description,
                    :ems_url,
                    :extra

      def initialize(subscription_id = nil)
        self.subscription_id = subscription_id
      end

      def path
        return PATH.gsub(/:subscription_id/, subscription_id) unless subscription_id.nil?
        PATH
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "payment" data from response' if response[:payment].nil?

        SyspaySDK::Entities::Payment.build_from_response(response[:payment])
      end

      def data
        hash = {}

        %i[subscription_id reference amount currency description ems_url extra].each do |attribute|
          hash[attribute] = send(attribute)
        end

        hash
      end
    end
  end
end
