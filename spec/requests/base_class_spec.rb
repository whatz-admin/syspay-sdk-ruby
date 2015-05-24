require 'spec_helper'

describe SyspaySDK::Requests::BaseClass do
  it { should respond_to(:get_method) }

  it "raises a SyspaySDK::Exceptions::NotImplementedError when #get_method is called" do
    lambda do
      subject.get_method()
    end.should raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end

  it { should respond_to(:get_path) }
  it "raises a SyspaySDK::Exceptions::NotImplementedError when #get_path is called" do
    lambda do
      subject.get_path()
    end.should raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end

  it { should respond_to(:build_response) }
  it "raises a SyspaySDK::Exceptions::NotImplementedError when #build_response is called" do
    lambda do
      subject.build_response()
    end.should raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end

  it { should respond_to(:get_data) }
  it "raises a SyspaySDK::Exceptions::NotImplementedError when #get_data is called" do
    lambda do
      subject.get_data()
    end.should raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end
end