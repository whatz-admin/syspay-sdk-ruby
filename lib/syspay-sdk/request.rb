module SyspaySDK
  class Request
    include SyspaySDK::AbstractClass

    abstract_methods :get_method, :get_path, :build_response, :get_data
  end
end