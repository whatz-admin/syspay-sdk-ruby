module SyspaySDK
  module Requests
    class BaseClass
      include SyspaySDK::Utils::AbstractClass

      abstract_methods :build_response, :data

      def http_method
        self.class::METHOD
      end

      def path
        self.class::PATH
      end
    end
  end
end
