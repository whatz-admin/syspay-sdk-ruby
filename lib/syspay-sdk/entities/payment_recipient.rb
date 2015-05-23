module SyspaySDK::Entities
  class PaymentRecipient < SyspaySDK::Entities::BaseClass
    TYPE = 'payment_recipient'

    CALC_TYPE_FIXED = 'fixed'
    CALC_TYPE_PERCENT = 'percent'

    attr_accessor :user_id, :account_id, :calc_type, :value, :currency, :settlement_delay
  end
end
