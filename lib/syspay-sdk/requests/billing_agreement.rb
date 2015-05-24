# Get the available banks to process AstroPay payments with.
module SyspaySDK::Requests
  class BillingAgreement < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/billing-agreement"

    FLOW_API = 'API'
    FLOW_BUYER = 'BUYER'
    FLOW_SELLER = 'SELLER'

    MODE_BOTH = 'BOTH'
    MODE_ONLINE = 'ONLINE'
    MODE_TERMINAL = 'TERMINAL'

    METHOD_ASTROPAY_BANKTRANSFER = 'ASTROPAY_BANKTRANSFER'
    METHOD_ASTROPAY_BOLETOBANCARIO = 'ASTROPAY_BOLETOBANCARIO'
    METHOD_ASTROPAY_DEBITCARD = 'ASTROPAY_DEBITCARD'
    METHOD_CLICKANDBUY = 'CLICKANDBUY'
    METHOD_CREDITCARD = 'CREDITCARD'
    METHOD_IDEAL = 'IDEAL'
    METHOD_PAYSAFECARD = 'PAYSAFECARD'
    METHOD_POSTFINANCE = 'POSTFINANCE'

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
    :credit_card,
    :bank_code,
    :reference,
    :currency,
    :description,
    :extra

    def initialize flow
      self.flow = flow
      raise SyspaySDK::Exceptions::InvalidArgumentError.new('Invalid flow: #{flow}') unless [ FLOW_API, FLOW_BUYER, FLOW_SELLER ].include?(flow)
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "billing_agreement" data from response') if response[:billing_agreement].nil?

      unless response[:billing_agreement].empty?
        billing_agreement = SyspaySDK::Entities::BillingAgreement::build_from_response(response[:billing_agreement]);
      else
        billing_agreement = SyspaySDK::Entities::BillingAgreement.new
      end

      billing_agreement.redirect = response[:redirect] unless response[:redirect].nil?

      billing_agreement
    end

    def get_data
      hash = {}
      hash[:flow] = self.flow;
      hash[:billing_agreement] = self.billing_agreement.nil? ? false : true
      hash[:mode] = self.mode
      hash[:mode] = self.mode
      hash[:threatmetrix_session_id] = self.threatmetrix_session_id
      hash[:method] = self.payment_method
      hash[:website] = self.website
      hash[:agent] = self.agent
      hash[:redirect_url] = self.redirect_url
      hash[:ems_url] = self.ems_url
      hash[:credit_card] = self.credit_card.to_hash unless self.credit_card.nil?
      hash[:customer] = self.customer.to_hash unless self.customer.nil?
      hash[:bank_code] = self.bank_code
      hash[:reference] = self.reference
      hash[:currency] = self.currency
      hash[:description] = self.description
      hash[:allowed_retries] = self.allowed_retries
      hash[:extra] = self.extra
      hash
    end
  end
end