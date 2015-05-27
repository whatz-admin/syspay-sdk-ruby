require 'json'
require 'pp'

module SyspaySDK
  module Exceptions

    class RequestError < StandardError
      def initialize(http_code, response_body)
        @http_code = http_code
        @response_body = response_body
      end

      def to_s
        "The request returned a #{@http_code} error with the following body: #{@response_body}"
      end
    end

    class InvalidChecksumError < StandardError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    # Raised when an argument is missing
    class MissingArgumentError < StandardError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    # Raised when an argument passed to a function is not
    # of the expected type
    class InvalidArgumentError < StandardError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    # Raised when an argument passed to a function is not
    # of the expected type
    class UnexpectedResponseError < StandardError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    # Raised when an argument passed to a function is not
    # of the expected type
    class BadArgumentTypeError < StandardError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    # Raised when a calling an abstract method
    class NotImplementedError < StandardError
      def initialize(message)
        @message = message
      end
      def to_s; @message ;end
    end

    class MissingConfig < StandardError
    end
  end
end