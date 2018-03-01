module SyspaySDK
  module Utils
    module AbstractClass
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def abstract_methods(*args)
          args.each do |name|
            class_eval <<-ABSTRACT_METHOD, __FILE__, __LINE__ + 1
              def #{name}(*args)
                raise SyspaySDK::Exceptions::NotImplementedError.new("#{self.class} must implement #{name}.")
              end
            ABSTRACT_METHOD
          end
        end
      end
    end
  end
end
