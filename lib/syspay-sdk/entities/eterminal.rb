module SyspaySDK::Entities
  class Eterminal < SyspaySDK::Entities::ReturnedEntity
    TYPE = "eterminal"

    attr_accessor :url

    def self.build_from_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)

      eterminal = self.new
      eterminal.url = response[:url]

      eterminal.raw = response
      eterminal
    end
  end
end