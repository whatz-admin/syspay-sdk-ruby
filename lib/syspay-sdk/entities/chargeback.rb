module SyspaySDK
  module Entities
    class Chargeback < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'chargeback'.freeze

      attr_accessor :id, :status, :amount, :currency, :reason_code, :payment, :processing_time, :bank_time

      def self.build_payment(response)
        SyspaySDK::Entities::Payment.build_from_response(response[:payment]) unless response[:payment].nil?
      end

      def self.assign_attributes(chargeback, response)
        %i[id status amount currency reason_code].each do |attribute|
          chargeback.send(:"#{attribute}=", response[attribute])
        end

        %i[processing_time bank_time].each do |attribute|
          unless response[attribute].nil? || response[attribute] == ''
            chargeback.send(:"#{attribute}=", Time.at(response[attribute].to_i))
          end
        end
      end

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        chargeback = new
        chargeback.raw = response

        assign_attributes(chargeback, response)

        chargeback.payment = build_payment(response)
        chargeback
      end
    end
  end
end
