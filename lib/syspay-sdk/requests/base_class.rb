module SyspaySDK::Requests
  class BaseClass
    include SyspaySDK::Utils::AbstractClass

    abstract_methods :get_path, :build_response, :get_data

    def get_method
      self.class::METHOD
    end
  end
end