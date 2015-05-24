# Get the available banks to process AstroPay payments with.
module SyspaySDK::Requests
  class AstroPayBank < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/astropay/banks/"

    attr_accessor :country

    def initialize country = nil
      self.country = country
    end

    def get_path
      "#{self.class::PATH}#{self.country}"
    end

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "banks" data from response') if response[:banks].nil? or !response[:banks].is_a?(Array)

      banks = []

      response[:banks].each do |bank|
        banks.push SyspaySDK::Entities::AstroPayBank.build_from_response(bank)
      end

      banks
    end
  end
end