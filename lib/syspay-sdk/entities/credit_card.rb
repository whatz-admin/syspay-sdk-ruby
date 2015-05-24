module SyspaySDK::Entities
  class CreditCard < SyspaySDK::Entities::BaseClass
    TYPE = "credit_card"

    attr_accessor :number, :cardholder, :cvc, :exp_month, :exp_year, :token

    def to_hash
      hash = {}

      if self.token.nil?
        [ :number, :cardholder, :cvc, :exp_month, :exp_year ].each do |attribute|
          hash[attribute] = self.send(attribute)
        end
      else
        hash[:token] = self.token
      end

      hash
    end
  end
end