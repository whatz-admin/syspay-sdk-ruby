# Get the available banks to process AstroPay payments with.
module SyspaySDK
  module Requests
    class AstroPayBank < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/astropay/banks/'.freeze

      attr_accessor :country

      def initialize(country = nil)
        self.country = country
      end

      def path
        "#{self.class::PATH}#{country}"
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "banks" data from response' if response[:banks].nil? || !response[:banks].is_a?(Array)

        banks = []

        response[:banks].each do |bank|
          banks.push SyspaySDK::Entities::AstroPayBank.build_from_response(bank)
        end

        banks
      end
    end
  end
end
