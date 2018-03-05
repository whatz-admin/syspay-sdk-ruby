module SyspaySDK
  module Entities
    class Subscription < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'subscription'.freeze

      STATUS_PENDING = 'PENDING'.freeze
      STATUS_ACTIVE = 'ACTIVE'.freeze
      STATUS_CANCELLED = 'CANCELLED'.freeze
      STATUS_ENDED = 'ENDED'.freeze
      STATUS_TERMINATED = 'TERMINATED'.freeze

      PHASE_NEW = 'NEW'.freeze
      PHASE_TRIAL = 'TRIAL'.freeze
      PHASE_BILLING = 'BILLING'.freeze
      PHASE_RETRY = 'RETRY'.freeze
      PHASE_LAST = 'LAST'.freeze
      PHASE_CLOSED = 'CLOSED'.freeze

      END_REASON_UNSUBSCRIBED_MERCHANT = 'UNSUBSCRIBED_MERCHANT'.freeze
      END_REASON_UNSUBSCRIBED_ADMIN = 'UNSUBSCRIBED_ADMIN'.freeze
      END_REASON_SUSPENDED_ATTEMPTS = 'SUSPENDED_ATTEMPTS'.freeze
      END_REASON_SUSPENDED_EXPIRED = 'SUSPENDED_EXPIRED'.freeze
      END_REASON_SUSPENDED_CHARGEBACK = 'SUSPENDED_CHARGEBACK'.freeze
      END_REASON_COMPLETE = 'COMPLETE'.freeze

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

      def assign_attributes(response)
        %i[
          id plan_id plan_type reference
          status phase extra ems_url end_reason
        ].each { |attribute| send(:"#{attribute}=", response[attribute]) }

        %i[created start_date end_date].each do |attribute|
          unless response[attribute].nil? || (response[attribute] == '')
            send(:"#{attribute}=", Time.at(response[attribute].to_i).to_date)
          end
        end
      end

      def self.build_payment_method(response)
        SyspaySDK::Entities::PaymentMethod.build_from_response(response[:payment_method]) unless response[:payment_method].nil?
      end

      def self.build_customer(response)
        SyspaySDK::Entities::Customer.build_from_response(response[:customer]) unless response[:customer].nil?
      end

      def self.build_plan(response)
        SyspaySDK::Entities::Plan.build_from_response(response[:plan]) unless response[:plan].nil?
      end

      def self.build_next_event(response)
        SyspaySDK::Entities::SubscriptionEvent.build_from_response(response[:next_event]) unless response[:next_event].nil?
      end

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        subscription = new

        subscription.assign_attributes(response)

        subscription.payment_method = build_payment_method(response)
        subscription.customer = build_customer(response)
        subscription.plan = build_plan(response)
        subscription.next_event = build_next_event(response)

        subscription.raw = response
        subscription
      end

      def to_hash
        hash = {}

        %i[ems_url redirect_url plan_id reference].each do |attribute|
          hash[attribute] = send(attribute)
        end

        hash[:extra] = extra.is_a?(Hash) ? extra.to_json : extra

        hash
      end
    end
  end
end
