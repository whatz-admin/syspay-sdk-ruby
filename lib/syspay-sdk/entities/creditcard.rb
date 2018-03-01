module SyspaySDK
  module Entities
    class CreditCard < SyspaySDK::Entities::BaseClass
      TYPE = 'creditcard'.freeze

      attr_accessor :number, :cardholder, :cvc, :exp_month, :exp_year, :token

      def to_hash
        hash = {}

        if token.nil?
          %i[number cardholder cvc exp_month exp_year].each do |attribute|
            hash[attribute] = send(attribute)
          end
        else
          hash[:token] = token
        end

        hash
      end
    end
  end
end
