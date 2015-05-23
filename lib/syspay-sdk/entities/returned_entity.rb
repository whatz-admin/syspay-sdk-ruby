module SyspaySDK::Entities
  class ReturnedEntity < SyspaySDK::Entities::BaseClass
    include SyspaySDK::Utils::AbstractClass
    abstract_methods :"self.build_from_response"
  end
end