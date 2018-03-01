module SyspaySDK
  module Entities
    class BaseClass
      include SyspaySDK::Utils::AbstractClass

      abstract_methods :to_hash

      attr_accessor :raw

      def type
        self.class::TYPE
      end
    end
  end
end
