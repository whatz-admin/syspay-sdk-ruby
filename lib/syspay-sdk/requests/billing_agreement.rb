# Get the available banks to process AstroPay payments with.
module SyspaySDK
  module Requests
    class BillingAgreement < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/billing-agreement'.freeze

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
                    :mode,
                    :payment_method,
                    :threatmetrix_session_id,
                    :billing_agreement,
                    :ems_url,
                    :redirect_url,
                    :website,
                    :agent,
                    :allowed_retries,
                    :payment,
                    :customer,
                    :creditcard,
                    :bank_code,
                    :reference,
                    :currency,
                    :description,
                    :extra

      def initialize(flow)
        self.flow = flow
        raise SyspaySDK::Exceptions::InvalidArgumentError, "Invalid flow: #{flow}" unless [FLOW_API, FLOW_BUYER, FLOW_SELLER].include?(flow)
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "billing_agreement" data from response' if response[:billing_agreement].nil?

        billing_agreement = if response[:billing_agreement].empty?
                              SyspaySDK::Entities::BillingAgreement.new
                            else
                              SyspaySDK::Entities::BillingAgreement.build_from_response(response[:billing_agreement])
                            end

        billing_agreement.redirect = response[:redirect] unless response[:redirect].nil?

        billing_agreement
      end

      def data
        hash = {
          billing_agreement: billing_agreement.nil? ? false : true,
          method: payment_method
        }

        %i[
          flow mode threatmetrix_session_id website agent redirect_url
          ems_url bank_code reference currency description allowed_retries extra
        ].each { |attribute| hash[attribute] = send(attribute) }

        %i[creditcard customer].each { |entity| hash[entity] = send(entity).to_hash unless send(entity).nil? }

        hash
      end
    end
  end
end
