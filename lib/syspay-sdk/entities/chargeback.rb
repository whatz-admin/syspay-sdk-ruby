module SyspaySDK::Entities
  class Chargeback < SyspaySDK::Entities::ReturnedEntity
    TYPE = "chargeback"

    attr_accessor :id, :status, :amount, :currency, :reason_code, :payment, :processing_time, :bank_time

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      chargeback = self.new

      chargeback.id = response[:id]
      chargeback.status = response[:status]
      chargeback.amount = response[:amount]
      chargeback.currency = response[:currency]
      chargeback.reason_code = response[:reason_code]

      chargeback.processing_time = (response[:processing_time].nil? or response[:processing_time] == "") ? nil : Time.at(response[:processing_time]).to_date
      chargeback.bank_time = (response[:bank_time].nil? or response[:bank_time] == "") ? nil : Time.at(response[:bank_time]).to_date

      chargeback.payment = SyspaySDK::Entities::Payment.build_from_response(response[:payment]) unless response[:payment].nil?

      chargeback.raw = response
      chargeback
    end
  end
end