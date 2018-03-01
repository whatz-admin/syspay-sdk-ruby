require 'base64'
require 'json'

module SyspaySDK
  class Redirect
    attr_accessor :syspay_id, :syspay_passphrase, :skip_auth_check

    def initialize(skip_auth_check = false)
      @syspay_id          = SyspaySDK::Config.config.syspay_id
      @syspay_passphrase  = SyspaySDK::Config.config.syspay_passphrase
      @skip_auth_check    = skip_auth_check
    end

    def validate_checksum(result, passphrase, checksum)
      raise SyspaySDK::Exceptions::MissingArgumentError, 'Missing Argument: result'     if result.nil?
      raise SyspaySDK::Exceptions::MissingArgumentError, 'Missing Argument: passphrase' if passphrase.nil?
      raise SyspaySDK::Exceptions::MissingArgumentError, 'Missing Argument: checksum'   if checksum.nil?

      raise SyspaySDK::Exceptions::InvalidChecksumError, 'Invalid checksum' if Digest::SHA1.hexdigest("#{result}#{passphrase}") != checksum
    end

    def decode_result(result)
      Base64.strict_decode64(result)
    rescue ArgumentError
      raise SyspaySDK::Exceptions::InvalidArgumentError, "Invalid result: #{result}"
    end

    def parse_result(result)
      result = JSON.parse(result)
      return result unless result[:payment].nil?
      raise SyspaySDK::Exceptions::InvalidArgumentError, "Invalid result: #{result}"
    rescue JSON::ParserError
      raise SyspaySDK::Exceptions::InvalidArgumentError, "Invalid result: #{result}"
    end

    def build_result(source)
      result   = source[:result]
      checksum = source[:checksum]

      validate_checksum(result, syspay_passphrase, checksum) unless skip_auth_check
      result = parse_result(
        decode_result(result)
      )

      SyspaySDK::Entities::Payment.build_from_response(result[:payment])
    end
  end
end
