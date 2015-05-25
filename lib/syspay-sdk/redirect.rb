module SyspaySDK
  class Redirect
    attr_accessor :syspay_id, :syspay_passphrase, :skip_auth_check

    def initialize skip_auth_check = false
      self.syspay_id = SyspaySDK::Config.config.syspay_id
      self.syspay_passphrase = SyspaySDK::Config.config.syspay_passphrase
      self.skip_auth_check = skip_auth_check
    end

    def validate_checksum result, passphrase, checksum
      raise SyspaySDK::Exceptions::MissingArgumentError.new("Missing Argument: result") if result.nil?
      raise SyspaySDK::Exceptions::MissingArgumentError.new("Missing Argument: passphrase") if passphrase.nil?
      raise SyspaySDK::Exceptions::MissingArgumentError.new("Missing Argument: checksum") if checksum.nil?

      raise SyspaySDK::Exceptions::InvalidChecksumError.new('Invalid checksum') if Digest::SHA1.hexdigest("#{result}#{passphrase}") != checksum
    end

    def get_result source
      result   = source[:result]
      checksum = source[:checksum]

      self.validate_checksum(result, self.syspay_passphrase, checksum) unless self.skip_auth_check

      begin
        result = Base64.strict_decode64(result)
      rescue ArgumentError
        raise SyspaySDK::Exceptions::InvalidArgumentError.new("Invalid result: #{result}")
      end

      begin
        result = JSON.parse result
        raise SyspaySDK::Exceptions::InvalidArgumentError.new("Invalid result: #{result}") if result[:payment].nil?
      rescue JSON::ParserError
        raise SyspaySDK::Exceptions::InvalidArgumentError.new("Invalid result: #{result}")
      end

      SyspaySDK::Entities::Payment.build_from_response(result[:payment])
    end
  end
end