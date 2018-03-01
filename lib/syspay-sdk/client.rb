require 'base64'
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

    def request(request_object)
      request = build_request_for request_object

      add_headers_to_request request

      response = build_https_object.request(request)

      http_code = response.code

      unless [200, 201].include?(http_code.to_i)
        raise SyspaySDK::Exceptions::RequestError.new(response['x-syspay-request-uuid'], http_code, response.body)
      end

      parse_response request_object, response
    end

    private

    def build_request_for(request_object)
      method = request_object.http_method.upcase

      if %w[PUT POST].include?(method)
        request = (method == 'PUT' ? Net::HTTP::Put : Net::HTTP::Post).new(request_object.path)
        request.body = request_object.data.to_json
        return request
      end

      if method == 'GET'
        return Net::HTTP::Get.new("#{request_object.path}?#{request_object.data.to_query}")
      end

      raise SyspaySDK::Exceptions::UnhandledMethodError, "Unhandled method : #{method}"
    end

    def add_headers_to_request(request)
      request['Accept']       = 'application/json'
      request['X-Wsse']       = generate_auth_header
      request['Content-Type'] = 'application/json'
    end

    def generate_auth_header
      timestamp = Time.now.to_i
      nonce     = Digest::MD5.digest(rand(1..50_000).to_s)
      b64nonce  = Base64.strict_encode64(nonce)

      digest = generate_digest_for_auth_header(nonce, timestamp)

      "AuthToken MerchantAPILogin=\"#{syspay_id}\", PasswordDigest=\"#{digest}\", Nonce=\"#{b64nonce}\", Created=\"#{timestamp}\""
    end

    def generate_digest_for_auth_header(nonce, timestamp)
      Base64.strict_encode64(
        Digest::SHA1.digest("#{nonce}#{timestamp}#{syspay_passphrase}")
      )
    end

    def build_https_object
      uri   = URI.parse(syspay_base_url)

      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      https
    end

    def parse_response(request_object, response)
      decoded_body = JSON.parse(response.body).recursive_symbolize_keys

      {
        response_object: request_object.build_response(decoded_body[:data]),
        request_data: request_object.data,
        response_data: response.body,
        response_code: response.code
      }
    end
  end
end
