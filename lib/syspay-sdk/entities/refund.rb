module SyspaySDK::Entities
  class Refund < SyspaySDK::Entities::ReturnedEntity
    TYPE = "refund"

    attr_accessor :id,
    :status,
    :reference,
    :amount,
    :currency,
    :description,
    :extra,
    :payment,
    :processing_time

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)

      refund = self.new

      refund.id = response[:id]
      refund.status = response[:status]
      refund.reference = response[:reference]
      refund.amount = response[:amount]
      refund.currency = response[:currency]
      refund.description = response[:description]
      refund.extra = response[:extra]

      refund.processing_time = (response[:processing_time].nil? or response[:processing_time] == "") ? nil : Time.at(response[:processing_time].to_i).to_date

      refund.payment = SyspaySDK::Entities::Payment.build_from_response(response[:payment]) unless response[:payment].nil?

      refund.raw = response
      refund
    end

    def to_hash
      hash = {}

      [ :reference, :amount, :currency, :description, :extra ].each do |attribute|
        hash[attribute] = self.send(attribute)
      end

      hash
    end
  end
end
