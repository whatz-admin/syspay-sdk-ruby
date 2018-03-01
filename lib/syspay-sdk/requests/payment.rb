# Get the available banks to process AstroPay payments with.
module SyspaySDK
  module Requests
    class Payment < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/payment'.freeze

      FLOW_API = 'API'.freeze
      FLOW_BUYER = 'BUYER'.freeze
      FLOW_SELLER = 'SELLER'.freeze

      MODE_BOTH = 'BOTH'.freeze
      MODE_ONLINE = 'ONLINE'.freeze
      MODE_TERMINAL = 'TERMINAL'.freeze

      METHOD_ASTROPAY_BANKTRANSFER = 'ASTROPAY_BANKTRANSFER'.freeze
      METHOD_ASTROPAY_BOLETOBANCARIO = 'ASTROPAY_BOLETOBANCARIO'.freeze
      METHOD_ASTROPAY_DEBITCARD = 'ASTROPAY_DEBITCARD'.freeze
      METHOD_CLICKANDBUY = 'CLICKANDBUY'.freeze
      METHOD_CREDITCARD = 'CREDITCARD'.freeze
      METHOD_IDEAL = 'IDEAL'.freeze
      METHOD_PAYSAFECARD = 'PAYSAFECARD'.freeze
      METHOD_POSTFINANCE = 'POSTFINANCE'.freeze

      attr_accessor :flow,
                    :method,
                    :threatmetrix_session_id,
                    :billing_agreement,
                    :ems_url,
                    :redirect_url,
                    :website,
                    :agent,
                    :payment,
                    :customer,
                    :creditcard

      def initialize(flow)
        raise SyspaySDK::Exceptions::InvalidArgumentError, "Invalid flow: #{flow}" unless [FLOW_API, FLOW_BUYER, FLOW_SELLER].include?(flow)

        self.flow = flow
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "payment" data from response' if response[:payment].nil?

        payment = if response[:payment].empty?
                    SyspaySDK::Entities::Payment.new
                  else
                    SyspaySDK::Entities::Payment.build_from_response(response[:payment])
                  end

        payment.redirect = response[:redirect] unless response[:redirect].nil?
        payment
      end

      def data
        hash = {}

        %i[flow threatmetrix_session_id method website agent redirect_url ems_url].each do |attribute|
          hash[attribute] = send(attribute)
        end

        %i[creditcard customer payment].each do |entity|
          hash[entity] = send(entity).to_hash unless send(entity).nil?
        end

        hash[:billing_agreement] = billing_agreement.nil? ? false : true

        hash
      end
    end
  end
end
