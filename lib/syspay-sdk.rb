module Syspay
  module SDK
    autoload :VERSION,        "syspay-sdk/version"
    autoload :Config,         "syspay-sdk/config"
    autoload :Configuration,  "syspay-sdk/config"
    autoload :Logging,        "syspay-sdk/logging"
    autoload :Exceptions,     "syspay-sdk/exceptions"
    autoload :Client,         "syspay-sdk/client"

    class << self
      def configure(options = {}, &block)
        Config.configure(options, &block)
      end

      def load(*args)
        Config.load(*args)
      end

      def logger
        Config.logger
      end

      def logger=(log)
        Config.logger = log
      end
    end
  end
end
