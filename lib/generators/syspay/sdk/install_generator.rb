module Syspay
  module Sdk
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def copy_config_file
          copy_file 'syspay.yml', 'config/syspay.yml'
        end

        def copy_initializer_file
          copy_file 'syspay.rb',  'config/initializers/syspay.rb'
        end
      end
    end
  end
end
