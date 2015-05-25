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
    autoload :CreditCard,         "syspay-sdk/entities/credit_card"
    autoload :Customer,           "syspay-sdk/entities/customer"
    autoload :Eterminal,          "syspay-sdk/entities/eterminal"
    autoload :PaymentMethod,      "syspay-sdk/entities/payment_method"
    autoload :Plan,               "syspay-sdk/entities/plan"
    autoload :Refund,             "syspay-sdk/entities/refund"
    autoload :Subscription,       "syspay-sdk/entities/subscription"
    autoload :SubscriptionEvent,  "syspay-sdk/entities/subscription_event"
  end

  module Requests
    autoload :BaseClass,                      "syspay-sdk/requests/base_class"
    autoload :AstroPayBank,                   "syspay-sdk/requests/astro_pay_bank"
    autoload :BillingAgreement,               "syspay-sdk/requests/billing_agreement"
    autoload :BillingAgreementCancellation,   "syspay-sdk/requests/billing_agreement_cancellation"
    autoload :BillingAgreementInfo,           "syspay-sdk/requests/billing_agreement_info"
    autoload :BillingAgreementList,           "syspay-sdk/requests/billing_agreement_list"
    autoload :ChargebackInfo,                 "syspay-sdk/requests/chargeback_info"
    autoload :ChargebackList,                 "syspay-sdk/requests/chargeback_list"
    autoload :Confirm,                        "syspay-sdk/requests/confirm"
    autoload :Eterminal,                      "syspay-sdk/requests/eterminal"
    autoload :IpAddresses,                    "syspay-sdk/requests/ip_addresses"
    autoload :Payment,                        "syspay-sdk/requests/payment"
    autoload :PaymentInfo,                    "syspay-sdk/requests/payment_info"
    autoload :PaymentList,                    "syspay-sdk/requests/payment_list"
    autoload :Plan,                           "syspay-sdk/requests/plan"
    autoload :PlanInfo,                       "syspay-sdk/requests/plan_info"
    autoload :PlanUpdate,                     "syspay-sdk/requests/plan_update"
    autoload :Rebill,                         "syspay-sdk/requests/rebill"
    autoload :Refund,                         "syspay-sdk/requests/refund"
    autoload :RefundInfo,                     "syspay-sdk/requests/refund_info"

  end

  module Utils
    autoload :AbstractClass, "syspay-sdk/utils/abstract_class"
  end
end
