module SyspaySDK
  module Entities
    class Plan < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'plan'.freeze

      UNIT_MINUTE = 'minute'.freeze
      UNIT_HOUR = 'hour'.freeze
      UNIT_DAY = 'day'.freeze
      UNIT_WEEK = 'week'.freeze
      UNIT_MONTH = 'month'.freeze
      UNIT_YEAR = 'year'.freeze

      TIME_UNITS = [UNIT_MINUTE, UNIT_HOUR, UNIT_DAY, UNIT_WEEK, UNIT_MONTH, UNIT_YEAR].freeze

      TYPE_SUBSCRIPTION = 'SUBSCRIPTION'.freeze
      TYPE_INSTALMENT = 'INSTALMENT'.freeze

      attr_accessor :id,
                    :created,
                    :status,
                    :type,
                    :name,
                    :description,
                    :currency,
                    :trial_amount,
                    :trial_period,
                    :trial_period_unit,
                    :trial_cycles,
                    :initial_amount,
                    :billing_amount,
                    :billing_period,
                    :billing_period_unit,
                    :billing_cycles,
                    :retry_map_id,
                    :total_amount

      def assign_attributes(response)
        %i[
          id status name description currency trial_amount trial_period
          trial_period_unit trial_cycles billing_amount billing_period
          billing_period_unit billing_cycles initial_amount retry_map_id type
        ].each do |attribute|
          send(:"#{attribute}=", response[attribute])
        end
      end

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        plan = new

        plan.assign_attributes(response)

        unless response[:created].nil? || response[:created] == ''
          plan.created = Time.at(response[:created].to_i)
        end

        plan.raw = response
        plan
      end

      def to_hash
        hash = {}

        %i[
          type name description currency trial_amount trial_period
          trial_period_unit trial_cycles initial_amount billing_amount
          billing_period billing_period_unit billing_cycles retry_map_id
          total_amount
        ].each { |attribute| hash[attribute] = send(attribute) }

        hash
      end
    end
  end
end
