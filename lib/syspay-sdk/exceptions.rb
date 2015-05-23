require 'json'
require 'pp'

module SyspaySDK
  module Exceptions
    # # Raised when an argument passed to a function is not
    # # of the expected type
    # class UnknownAttributeError < StandardError
    #   def initialize(message)
    #     @message = message
    #   end
    #   def to_s; @message ;end
    # end

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