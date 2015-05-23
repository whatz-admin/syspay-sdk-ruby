require 'spec_helper'

describe SyspaySDK::Utils::AbstractClass do
  before(:each) do
    @klass = Class.new do
      include SyspaySDK::Utils::AbstractClass
      abstract_methods :foo, :bar
    end
  end

  it "raises SyspaySDK::Exceptions::NotImplementedError when an abstract method is called" do
    proc {
      @klass.new.foo
    }.should raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end

  it "can be overridden" do
    subclass = Class.new(@klass) do
      def foo
        :overridden
      end
    end

    subclass.new.foo.should == :overridden
  end
end