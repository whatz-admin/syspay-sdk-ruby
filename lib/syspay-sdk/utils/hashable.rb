module SyspaySDK::Utils
  module Hashable
    attr_accessor :hashable_attributes_array

    def hashable_attributes *attributes
      attributes.each do |attribute|
        begin
          self.send(attribute)
        rescue NoMethodError
          raise SyspaySDK::Exceptions::UnknownAttributeError.new("#{attribute} is not a valid hashable attribute.")
        end
      end
      self.hashable_attributes_array = attributes
    end

    def to_hash
      hash = {}
      self.hashable_attributes_array.each do |attribute|
        begin
          hash[attribute] = self.send(attribute)
        rescue
        end
      end
      hash
    end
  end
end
