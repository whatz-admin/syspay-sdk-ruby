module SyspaySDK::Entities
  class SubscriptionEvent < SyspaySDK::Entities::ReturnedEntity
    TYPE = 'subscription_event'

    TYPE_TRIAL = 'TRIAL'
    TYPE_FREE_TRIAL = 'FREE_TRIAL'
    TYPE_INITIAL = 'INITIAL'
    TYPE_BILL = 'BILL'
    TYPE_END = 'END'

    attr_accessor :event_type, :scheduled_date

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)

      subscription_event = self.new

      subscription_event.event_type = response[:event_type]

      subscription_event.scheduled_date = (response[:scheduled_date].nil? or response[:scheduled_date] == "") ? nil : Time.at(response[:scheduled_date]).to_date

      subscription_event.raw = response
      subscription_event
    end
  end
end