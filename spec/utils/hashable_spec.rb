require 'spec_helper'

describe SyspaySDK::Utils::Hashable do
  let(:subject) { HashableTestClass.new }

  it "has an array of attributes to return in hash called 'hashable_attributes_array'" do
    subject.should respond_to(:hashable_attributes_array)
  end

  it "responds to hashable_attributes" do
    subject.should respond_to(:hashable_attributes)
  end

  describe "#hashable_attributes" do
    it "sets hashable_attributes_array to the array of attributes passed in" do
      subject.hashable_attributes :attribute_1, :attribute_2
      subject.hashable_attributes_array.should eq([:attribute_1, :attribute_2])
    end

    it "raises an error when passing non existing attribute" do
      lambda do
        subject.hashable_attributes(:attribute_1, :attribute_4)
      end.should raise_error(SyspaySDK::Exceptions::UnknownAttributeError)
    end
  end

  it "responds to #to_hash" do
    subject.should respond_to(:to_hash)
  end

  describe "#to_hash" do
    it "returns a hash with proper values" do
      subject.attribute_1 = "attribute_1"
      subject.attribute_2 = "attribute_2"
      subject.attribute_3 = "attribute_3"

      subject.hashable_attributes :attribute_1, :attribute_3

      subject.to_hash.should eq( { attribute_1: "attribute_1", attribute_3: "attribute_3" } )
    end
  end
end

class HashableTestClass
  include SyspaySDK::Utils::Hashable

  attr_accessor :attribute_1,
  :attribute_2,
  :attribute_3
end