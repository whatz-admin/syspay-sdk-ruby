# Get the available banks to process AstroPay payments with.
module SyspaySDK::Requests
  class IpAddresses < SyspaySDK::Requests::BaseClass
    METHOD = "GET"
    PATH = "/api/v1/merchant/system-ip/"

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "ip_addresses" data from response') if response[:ip_addresses].nil? or !response[:ip_addresses].is_a?(Array)

      response[:ip_addresses]
    end
  end
end