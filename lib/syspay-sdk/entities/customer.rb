module SyspaySDK
  module Entities
    class Customer < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'customer'.freeze

      attr_accessor :id, :email, :language, :ip, :mobile

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        customer = new

        customer.id = response[:id]
        customer.email = response[:email]
        customer.language = response[:language]
        customer.ip = response[:ip]
        customer.mobile = response[:mobile]

        customer.raw = response
        customer
      end

      def to_hash
        { id: id, email: email, language: language, ip: ip, mobile: mobile }
      end
    end
  end
end
