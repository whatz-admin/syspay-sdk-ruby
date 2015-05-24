module SyspaySDK::Requests
  class BaseClass
    include SyspaySDK::Utils::AbstractClass

    abstract_methods :build_response, :get_data

    def get_method
      self.class::METHOD
    end

    def get_path
      self.class::PATH
    end
  end
end