require 'json'
require 'pp'

module SyspaySDK
  module Exceptions
    class ConnectionError < StandardError
      attr_reader :response

      def initialize(response, message = nil)
        @response = response
        @message  = message
      end

      def to_s
        begin
          response_body = JSON.parse(response.body)
          debug_id = response_body["debug_id"]
        rescue
        end
        message = "Failed."
        message << "  Response code = #{response.code}." if response.respond_to?(:code)
        message << "  Response message = #{response.message}." if response.respond_to?(:message)
        message << "  Response debug ID = #{debug_id}." if debug_id
        message
      end
    end

    # Raised when a calling an abstract method
    class NotImplementedError < StandardError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    # Raised when a Timeout::Error occurs.
    class TimeoutError < ConnectionError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    # Raised when a OpenSSL::SSL::SSLError occurs.
    class SSLError < ConnectionError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    # 3xx Redirection
    class Redirection < ConnectionError
      def to_s
        response['Location'] ? "#{super} => #{response['Location']}" : super
      end
    end

    class MissingParam < ArgumentError
    end

    class MissingConfig < StandardError
    end

    # 4xx Client Error
    class ClientError < ConnectionError
    end

    # 400 Bad Request
    class BadRequest < ClientError
    end

    # 401 Unauthorized
    class UnauthorizedAccess < ClientError
    end

    # 403 Forbidden
    class ForbiddenAccess < ClientError
    end

    # 404 Not Found
    class ResourceNotFound < ClientError
    end

    # 409 Conflict
    class ResourceConflict < ClientError
    end

    # 410 Gone
    class ResourceGone < ClientError
    end

    # 5xx Server Error
    class ServerError < ConnectionError
    end

    # 405 Method Not Allowed
    class MethodNotAllowed < ClientError
      def allowed_methods
        @response['Allow'].split(',').map { |verb| verb.strip.downcase.to_sym }
      end
    end
  end
end