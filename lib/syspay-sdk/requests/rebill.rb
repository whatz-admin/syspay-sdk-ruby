module SyspaySDK::Requests
  class Rebill < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/billing-agreement/:billing_agreement_id/rebill"

    attr_accessor :threatmetrix_session_id,
    :ems_url,
    :billing_agreement_id,
    :reference,
    :amount,
    :currency,
    :description,
    :extra,
    :recipient_map

    def initialize billing_agreement_id = nil
      self.billing_agreement_id = billing_agreement_id
    end

    def get_path
      return PATH.gsub(/:billing_agreement_id/, self.billing_agreement_id) unless self.billing_agreement_id.nil?
      return PATH
    end

    def set_recipient_map recipient_map
      recipient_map.each do |recipient|
        raise SyspaySDK::Exceptions::BadArgumentTypeError.new('set_recipient_map expects an array of SyspaySDK::Entities::PaymentRecipient') unless recipient.is_a?(SyspaySDK::Entities::PaymentRecipient)
      end
      self.recipient_map = recipient_map
    end

    def add_recipient recipient
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new('add_recipient expects a SyspaySDK::Entities::PaymentRecipient') unless recipient.is_a?(SyspaySDK::Entities::PaymentRecipient)
      self.recipient_map ||= []
      self.recipient_map.push recipient
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "payment" data from response') if response[:payment].nil?

      SyspaySDK::Entities::Payment::build_from_response(response[:payment]);
    end

    def get_data
      hash = {}

      [:threatmetrix_session_id, :ems_url].each do |attribute|
        hash[attribute] = self.send(attribute)
      end

      hash[:payment] = {}

     [:reference, :amount, :currency, :description, :extra ].each do |attribute|
        hash[:payment][attribute] = self.send(attribute)
      end

      hash[:payment][:recipient_map] = []
      self.recipient_map.each do |recipient|
        hash[:payment][:recipient_map].push recipient.to_hash
      end unless recipient_map.nil?

      hash
    end
  end
end