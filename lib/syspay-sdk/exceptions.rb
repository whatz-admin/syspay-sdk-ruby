module SyspaySDK
  module Exceptions
    class RequestError < StandardError
      def initialize(uuid, http_code, response_body)
        @uuid           = uuid
        @http_code      = http_code
        @response_body  = response_body
      end

      def to_s
        "The request #{@uuid} returned a #{@http_code} error with the following body: #{@response_body}"
      end
    end

    class InvalidChecksumError < StandardError
    end

    # Raised when an argument is missing
    class MissingArgumentError < StandardError
    end

    # Raised when an argument passed to a function is not
    # of the expected type
    class InvalidArgumentError < StandardError
    end

    # Raised when an argument passed to a function is not
    # of the expected type
    class UnexpectedResponseError < StandardError
    end

    # Raised when an argument passed to a function is not
    # of the expected type
    class BadArgumentTypeError < StandardError
    end

    # Raised when a calling an abstract method
    class NotImplementedError < StandardError
    end

    class MissingConfig < StandardError
    end

    class UnhandledMethodError < StandardError
    end

    class EMSError < StandardError
      attr_reader :error_code

      def initialize(message, error_code)
        @message = message
        @error_code = error_code
      end

      def to_s
        "#{@message}. Error code : #{@error_code}"
      end
    end
  end
end
