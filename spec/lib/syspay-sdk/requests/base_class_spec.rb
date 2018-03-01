require 'spec_helper'

describe SyspaySDK::Requests::BaseClass do
  it { is_expected.to respond_to(:http_method) }
  it { is_expected.to respond_to(:path) }

  it 'raises a SyspaySDK::Exceptions::NotImplementedError when #build_response is called' do
    expect do
      subject.build_response
    end.to raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end

  it 'raises a SyspaySDK::Exceptions::NotImplementedError when #data is called' do
    expect do
      subject.data
    end.to raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end
end
