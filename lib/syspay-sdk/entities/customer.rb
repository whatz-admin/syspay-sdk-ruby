module SyspaySDK::Entities
  class Customer < SyspaySDK::Entities::ReturnedEntity

    TYPE = 'customer'

    attr_accessor :email, :language, :ip, :mobile

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)

      customer = self.new

      customer.email = response[:email]
      customer.language = response[:language]
      customer.ip = response[:ip]
      customer.mobile = response[:mobile]

      customer.raw = response
      customer
    end
  end
end