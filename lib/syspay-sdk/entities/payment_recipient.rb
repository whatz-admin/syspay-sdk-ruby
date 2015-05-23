module SyspaySDK::Entities
  class PaymentRecipient < SyspaySDK::Entities::BaseClass
    TYPE = 'payment_recipient'

    CALC_TYPE_FIXED = 'fixed'
    CALC_TYPE_PERCENT = 'percent'

    attr_accessor :user_id, :account_id, :calc_type, :value, :currency, :settlement_delay

    def to_hash
      hash = {}

      [ :user_id, :account_id, :calc_type, :value, :currency, :settlement_delay ].each do |attribute|
        hash[attribute] = self.send(attribute)
      end

      hash
    end
  end
end
