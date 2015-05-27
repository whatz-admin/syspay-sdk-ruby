require "base64"
require 'digest'
require 'net/http'

# Base API client
# @see https://app.syspay.com/bundles/emiuser/doc/merchant_api.html#emerchant-rest-api

module SyspaySDK
  class Client
    attr_accessor :syspay_id,
    :syspay_passphrase,
    :syspay_base_url,
    :request_object,
    :response

    # Creates a new Client object initialized with Config parameters
    def initialize
      self.syspay_id = SyspaySDK::Config.config.syspay_id
      self.syspay_passphrase = SyspaySDK::Config.config.syspay_passphrase
      self.syspay_base_url = SyspaySDK::Config.config.syspay_base_url
    end

    # Generates the x-wsse header
    def generate_auth_header
      timestamp = Time.now.to_i

      nonce = Digest::MD5.hexdigest(rand().to_s)
      b64nonce = Base64.strict_encode64(nonce)

      digest = generate_digest_for_auth_header(nonce, timestamp, self.syspay_passphrase)

      "AuthToken MerchantAPILogin='#{self.syspay_id}', PasswordDigest='#{digest}', Nonce='#{nonce}', Created='#{timestamp}'"
    end

    def generate_digest_for_auth_header nonce, timestamp, passphrase
      Base64.strict_encode64(Digest::SHA1.hexdigest("#{nonce}#{timestamp}#{passphrase}"))
    end

    def request request
      self.request_object = request
      self.response = nil

      method = self.request_object.get_method.upcase

      self.response = case method
      when 'PUT'
        self.send_put_request
      when 'POST'
        self.send_post_request
      when 'GET'
        self.send_get_request
      else
        raise SyspaySDK::Exceptions::UnhandledMethodError.new("Unhandled method : #{method}")
      end

      http_code = self.response.code
      raise SyspaySDK::Exceptions::RequestError.new(http_code, self.response) unless [200, 201].include?(http_code.to_i)

      decoded_body = JSON.parse(self.response.body);
      if decoded_body.is_a?(Hash) and
        !decoded_body[:data].nil? and
        decoded_body[:data].is_a?(Hash)
        return self.request_object.build_response(decoded_body[:data]);
      else
        raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to decode response from json', self.response.body);
      end
    end

    def send_get_request
      uri = URI.parse(self.syspay_base_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      path = "#{self.request_object.get_path}?#{self.request_object.get_data.to_query}"
      request = Net::HTTP::Get.new()

      request["User-Agent"] = "Quinto"
      request["X-Wsse"] = self.generate_auth_header
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      https.request(request)
    end

    def send_post_request
      uri = URI.parse(self.syspay_base_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(self.request_object.get_path)
      request.body = self.request_object.get_data.to_json

      request["User-Agent"] = "Quinto"
      request["X-Wsse"] = self.generate_auth_header
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      https.request(request)
    end

    def send_put_request
      uri = URI.parse(self.syspay_base_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(self.request_object.get_path)
      request.body = self.request_object.get_data.to_json

      request["User-Agent"] = "Quinto"
      request["X-Wsse"] = self.generate_auth_header
      request["Content-Type"] = "application/json"
      request["Accept"] = "application/json"
      https.request(request)
    end
  end
end
