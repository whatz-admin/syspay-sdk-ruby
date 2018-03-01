# Get the available banks to process AstroPay payments with.
module SyspaySDK
  module Requests
    class IpAddresses < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/system-ip/'.freeze

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "ip_addresses" data from response' if response[:ip_addresses].nil? || !response[:ip_addresses].is_a?(Array)

        response[:ip_addresses]
      end
    end
  end
end
