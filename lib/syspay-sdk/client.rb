require "base64"
require 'digest'
require 'net/http'

module SyspaySDK
  class Client
    attr_accessor :syspay_id, :syspay_passphrase, :syspay_base_url

    def initialize
      @syspay_id          = SyspaySDK::Config.config.syspay_id
      @syspay_passphrase  = SyspaySDK::Config.config.syspay_passphrase
      @syspay_base_url    = SyspaySDK::Config.config.syspay_base_url
    end

    def request request_object
      request = build_request_for request_object

      add_headers_to_request request

      response = get_https_object.request(request)

      http_code = response.code

      unless [200, 201].include?(http_code.to_i)
        raise SyspaySDK::Exceptions::RequestError.new(http_code, response)
      end

      parse_response request_object, response
    end

    private

    def build_request_for request_object
      method = request_object.get_method.upcase

      case method
      when 'PUT'
        request = Net::HTTP::Put.new(request_object.get_path)
        request.body = request_object.get_data.to_json
        request
      when 'POST'
        request = Net::HTTP::Post.new(request_object.get_path)
        request.body = request_object.get_data.to_json
        request
      when 'GET'
        Net::HTTP::Get.new("#{request_object.get_path}?#{request_object.get_data.to_query}")
      else
        raise SyspaySDK::Exceptions::UnhandledMethodError.new("Unhandled method : #{method}")
      end
    end

    def add_headers_to_request request
      request["Accept"]       = "application/json"
      request["X-Wsse"]       = generate_auth_header
      request["Content-Type"] = "application/json"
    end

    def generate_auth_header
      timestamp = Time.now.to_i
      nonce     = Digest::MD5.hexdigest(rand().to_s)

      digest = generate_digest_for_auth_header(nonce, timestamp)

      "AuthToken MerchantAPILogin='#{syspay_id}', PasswordDigest='#{digest}', Nonce='#{nonce}', Created='#{timestamp}'"
    end

    def generate_digest_for_auth_header nonce, timestamp
      Base64.strict_encode64(
        Digest::SHA1.hexdigest("#{nonce}#{timestamp}#{syspay_passphrase}")
      )
    end

    def get_https_object
      uri   = URI.parse(syspay_base_url)

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      https
    end

    def parse_response request_object, response
      decoded_body = JSON.parse(response.body);

      request_object.build_response(decoded_body[:data]);
    end
  end
end
