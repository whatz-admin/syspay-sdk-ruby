module SyspaySDK::Entities
  class AstroPayBank < SyspaySDK::Entities::ReturnedEntity
    attr_accessor :code, :name, :logo_url

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      astro_pay_bank = self.new

      astro_pay_bank.code = response[:code]
      astro_pay_bank.name = response[:name]
      astro_pay_bank.logo_url = response[:logo_url]

      astro_pay_bank.raw = response

      astro_pay_bank
    end
  end
end