module SyspaySDK
  autoload :VERSION,        "syspay-sdk/version"
  autoload :Config,         "syspay-sdk/config"
  autoload :Configuration,  "syspay-sdk/config"
  autoload :Logging,        "syspay-sdk/logging"
  autoload :Exceptions,     "syspay-sdk/exceptions"
  autoload :Client,         "syspay-sdk/client"
  autoload :Request,        "syspay-sdk/request"

  class << self
    def configure(options = {}, &block)
      Config.configure(options, &block)
    end

    def load(*args)
      Config.load(*args)
    end

    def logger
      Config.logger
    end

    def logger=(log)
      Config.logger = log
    end
  end

  module Entities
    autoload :BaseClass,          "syspay-sdk/entities/base_class"
    autoload :ReturnedEntity,     "syspay-sdk/entities/returned_entity"
    autoload :Payment,            "syspay-sdk/entities/payment"
    autoload :PaymentRecipient,   "syspay-sdk/entities/payment_recipient"
    autoload :AstroPayBank,       "syspay-sdk/entities/astro_pay_bank"
    autoload :BillingAgreement,   "syspay-sdk/entities/billing_agreement"
    autoload :Chargeback,         "syspay-sdk/entities/chargeback"
  end

  module Utils
    autoload :AbstractClass, "syspay-sdk/utils/abstract_class"
  end
end
