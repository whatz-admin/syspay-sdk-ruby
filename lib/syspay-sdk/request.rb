module SyspaySDK
  class Request
    include SyspaySDK::Utils::AbstractClass

    abstract_methods :get_method, :get_path, :build_response, :get_data
  end
end