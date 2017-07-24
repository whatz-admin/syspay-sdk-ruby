module SyspaySDK::Utils
  module AbstractClass
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def abstract_methods(*args)
        args.each do |name|
          class_eval <<-"end_eval", __FILE__, __LINE__
            def #{name}(*args)
              raise SyspaySDK::Exceptions::NotImplementedError.new("#{self.class} must implement #{name}.")
            end
          end_eval
        end
      end
    end
  end
end