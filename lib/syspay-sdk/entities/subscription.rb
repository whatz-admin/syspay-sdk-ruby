module SyspaySDK::Entities
  class Subscription < SyspaySDK::Entities::ReturnedEntity
    TYPE = 'subscription'

    STATUS_PENDING = 'PENDING'
    STATUS_ACTIVE = 'ACTIVE'
    STATUS_CANCELLED = 'CANCELLED'
    STATUS_ENDED = 'ENDED'

    PHASE_NEW = 'NEW'
    PHASE_TRIAL = 'TRIAL'
    PHASE_BILLING = 'BILLING'
    PHASE_RETRY = 'RETRY'
    PHASE_LAST = 'LAST'
    PHASE_CLOSED = 'CLOSED'

    END_REASON_UNSUBSCRIBED_MERCHANT = 'UNSUBSCRIBED_MERCHANT'
    END_REASON_UNSUBSCRIBED_ADMIN = 'UNSUBSCRIBED_ADMIN'
    END_REASON_SUSPENDED_ATTEMPTS = 'SUSPENDED_ATTEMPTS'
    END_REASON_SUSPENDED_EXPIRED = 'SUSPENDED_EXPIRED'
    END_REASON_SUSPENDED_CHARGEBACK = 'SUSPENDED_CHARGEBACK'
    END_REASON_COMPLETE = 'COMPLETE'

    attr_accessor :id,
    :created,
    :start_date,
    :end_date,
    :status,
    :phase,
    :end_reason,
    :payment_method,
    :website,
    :ems_url,
    :redirect_url,
    :plan,
    :customer,
    :plan_id,
    :plan_type,
    :extra,
    :reference,
    :redirect,
    :next_event

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)

      subscription = self.new

      subscription.id = response[:id]
      subscription.plan_id = response[:plan_id]
      subscription.plan_type = response[:plan_type]
      subscription.reference = response[:reference]
      subscription.status = response[:status]
      subscription.phase = response[:phase]
      subscription.extra = response[:extra]
      subscription.ems_url = response[:ems_url]
      subscription.end_reason = response[:end_reason]

      subscription.created = (response[:created].nil? or response[:created] == "") ? nil : Time.at(response[:created]).to_date
      subscription.start_date = (response[:start_date].nil? or response[:start_date] == "") ? nil : Time.at(response[:start_date]).to_date
      subscription.end_date = (response[:end_date].nil? or response[:end_date] == "") ? nil : Time.at(response[:end_date]).to_date

      subscription.payment_method = SyspaySDK::Entities::PaymentMethod.build_from_response(response[:payment_method]) unless response[:payment_method].nil?
      subscription.customer = SyspaySDK::Entities::Customer.build_from_response(response[:customer]) unless response[:customer].nil?
      subscription.plan = SyspaySDK::Entities::Plan.build_from_response(response[:plan]) unless response[:plan].nil?

      subscription.raw = response
      subscription
    end
  end
end
