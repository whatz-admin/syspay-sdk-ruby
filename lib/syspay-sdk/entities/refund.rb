module SyspaySDK
  module Entities
    class Refund < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'refund'.freeze

      attr_accessor :id,
                    :status,
                    :reference,
                    :amount,
                    :currency,
                    :description,
                    :extra,
                    :payment,
                    :processing_time

      def assign_attributes(response)
        %i[
          id status reference amount
          currency description extra
        ].each { |attribute| send(:"#{attribute}=", response[attribute]) }

        return if response[:processing_time].nil? || response[:processing_time] == ''

        self.processing_time = Time.at(response[:processing_time].to_i)
      end

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        refund = new

        refund.assign_attributes(response)

        refund.payment = SyspaySDK::Entities::Payment.build_from_response(response[:payment]) unless response[:payment].nil?

        refund.raw = response
        refund
      end

      def to_hash
        hash = {}

        %i[reference amount currency description extra].each do |attribute|
          hash[attribute] = send(attribute)
        end

        hash
      end
    end
  end
end
