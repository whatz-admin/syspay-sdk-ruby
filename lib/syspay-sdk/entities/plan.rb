module SyspaySDK::Entities
  class Plan < SyspaySDK::Entities::ReturnedEntity
    TYPE = "plan"

    UNIT_MINUTE = 'minute'
    UNIT_HOUR = 'hour'
    UNIT_DAY = 'day'
    UNIT_WEEK = 'week'
    UNIT_MONTH = 'month'
    UNIT_YEAR = 'year'

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

      plan.created = (response[:created].nil? or response[:created] == "") ? nil : Time.at(response[:created]).to_date

      plan.raw = response
      plan
    end
  end
end