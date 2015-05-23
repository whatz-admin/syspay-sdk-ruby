module SyspaySDK::Entities
  module ReturnedEntity
    def self.included(base)
      base.class_eval do
        def self.build_from_response response
          raise SyspaySDK::Exceptions::NotImplementedError.new("You must implement #{name}.")
        end
      end
    end
  end
end