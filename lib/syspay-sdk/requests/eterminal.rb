module SyspaySDK
  module Requests
    class Eterminal < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/eterminal'.freeze

      TYPE_ONESHOT = 'ONESHOT'.freeze
      TYPE_SUBSCRIPTION = 'SUBSCRIPTION'.freeze
      TYPE_PAYMENT_PLAN = 'PAYMENT_PLAN'.freeze
      TYPE_PAYMENT_MANDATE = 'PAYMENT_MANDATE'.freeze
      attr_accessor :website,
                    :locked,
                    :ems_url,
                    :payment_redirect_url,
                    :eterminal_redirect_url,
                    :type,
                    :description,
                    :reference,
                    :customer,
                    :oneshot,
                    :subscription,
                    :payment_plan,
                    :payment_mandate,
                    :allowed_retries

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "eterminal" data from response' if response[:eterminal].nil?

        SyspaySDK::Entities::Eterminal.build_from_response(response[:eterminal])
      end

      def data
        hash = {}

        %i[
          type website ems_url payment_redirect_url eterminal_redirect_url
          description reference customer oneshot subscription
          payment_plan payment_mandate allowed_retries
        ].each do |attribute|
          hash[attribute] = send(attribute)
        end

        hash[:locked] = locked.nil? || (locked == false) ? false : true

        hash
      end
    end
  end
end
