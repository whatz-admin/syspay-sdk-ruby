require 'spec_helper'

describe SyspaySDK::Requests::BaseClass do
  it { is_expected.to respond_to(:get_method) }
  it { is_expected.to respond_to(:get_path) }

  it "raises a SyspaySDK::Exceptions::NotImplementedError when #build_response is called" do
    expect {
      subject.build_response()
    }.to raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end

  it "raises a SyspaySDK::Exceptions::NotImplementedError when #get_data is called" do
    expect {
      subject.get_data()
    }.to raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end
end