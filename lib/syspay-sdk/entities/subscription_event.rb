module SyspaySDK
  module Entities
    class SubscriptionEvent < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'subscription_event'.freeze

      TYPE_TRIAL = 'TRIAL'.freeze
      TYPE_FREE_TRIAL = 'FREE_TRIAL'.freeze
      TYPE_INITIAL = 'INITIAL'.freeze
      TYPE_BILL = 'BILL'.freeze
      TYPE_END = 'END'.freeze

      attr_accessor :event_type, :scheduled_date

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        subscription_event = new

        subscription_event.event_type = response[:event_type]

        unless response[:scheduled_date].nil? || response[:scheduled_date] == ''
          subscription_event.scheduled_date = Time.at(response[:scheduled_date].to_i)
        end

        subscription_event.raw = response
        subscription_event
      end
    end
  end
end
