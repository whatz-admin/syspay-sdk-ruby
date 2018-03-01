module SyspaySDK
  module Entities
    class Eterminal < SyspaySDK::Entities::ReturnedEntity
      TYPE = 'eterminal'.freeze

      attr_accessor :url

      def self.build_from_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)

        eterminal = new
        eterminal.url = response[:url]

        eterminal.raw = response
        eterminal
      end
    end
  end
end
