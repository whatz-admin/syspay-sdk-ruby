require 'logger'

module SyspaySDK
  module Logging
    def logger
      @logger ||= Logging.logger
    end

    def log_event(message)
      start_time = Time.now
      yield
    ensure
      logger.info format('[%<time>.3fs] %<message>s', time: Time.now - start_time, message: message)
    end

    class << self
      def logger
        @logger ||= Logger.new(STDERR)
      end

      attr_writer :logger
    end
  end
end
