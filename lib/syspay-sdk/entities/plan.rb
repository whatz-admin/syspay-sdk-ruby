module SyspaySDK::Entities
  class Plan < SyspaySDK::Entities::ReturnedEntity
    TYPE = "plan"

    UNIT_MINUTE = 'minute'
    UNIT_HOUR = 'hour'
    UNIT_DAY = 'day'
    UNIT_WEEK = 'week'
    UNIT_MONTH = 'month'
    UNIT_YEAR = 'year'

    TIME_UNITS = [UNIT_MINUTE, UNIT_HOUR, UNIT_DAY, UNIT_WEEK, UNIT_MONTH, UNIT_YEAR]

    TYPE_SUBSCRIPTION = 'SUBSCRIPTION'
    TYPE_INSTALMENT = 'INSTALMENT'

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

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      plan = self.new

      plan.id = response[:id]
      plan.status = response[:status]
      plan.name = response[:name]
      plan.description = response[:description]
      plan.currency = response[:currency]
      plan.trial_amount = response[:trial_amount]
      plan.trial_period = response[:trial_period]
      plan.trial_period_unit = response[:trial_period_unit]
      plan.trial_cycles = response[:trial_cycles]
      plan.billing_amount = response[:billing_amount]
      plan.billing_period = response[:billing_period]
      plan.billing_period_unit = response[:billing_period_unit]
      plan.billing_cycles = response[:billing_cycles]
      plan.initial_amount = response[:initial_amount]
      plan.retry_map_id = response[:retry_map_id]
      plan.type = response[:type]

      plan.created = (response[:created].nil? or response[:created] == "") ? nil : Time.at(response[:created].to_i).to_date

      plan.raw = response
      plan
    end

    def to_hash
      hash = {}
      hash[:type] = self.type
      hash[:name] = self.name
      hash[:description] = self.description
      hash[:currency] = self.currency
      hash[:trial_amount] = self.trial_amount
      hash[:trial_period] = self.trial_period
      hash[:trial_period_unit] = self.trial_period_unit
      hash[:trial_cycles] = self.trial_cycles
      hash[:initial_amount] = self.initial_amount
      hash[:billing_amount] = self.billing_amount
      hash[:billing_period] = self.billing_period
      hash[:billing_period_unit] = self.billing_period_unit
      hash[:billing_cycles] = self.billing_cycles
      hash[:retry_map_id] = self.retry_map_id
      hash[:total_amount] = self.total_amount
      hash
    end
  end
end