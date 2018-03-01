require 'spec_helper'

describe SyspaySDK::Utils::AbstractClass do
  class TestAbstractClass
    include SyspaySDK::Utils::AbstractClass
    abstract_methods :foo, :bar
  end

  it 'raises SyspaySDK::Exceptions::NotImplementedError when an abstract method is called' do
    expect do
      TestAbstractClass.new.foo
    end.to raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end

  it 'can be overridden' do
    subclass = Class.new(TestAbstractClass) do
      def foo
        :overridden
      end
    end

    expect(subclass.new.foo).to eq :overridden
  end
end
