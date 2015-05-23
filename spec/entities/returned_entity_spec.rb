require 'spec_helper'

describe SyspaySDK::Entities::ReturnedEntity do
  it "is a SyspaySDK::Entities::BaseClass" do
    subject.should be_a(SyspaySDK::Entities::BaseClass)
  end

  it "responds to build_from_response" do
    SyspaySDK::Entities::ReturnedEntity.should respond_to(:build_from_response)
  end

  it "raises an error when build_from_response method is not implemented" do
    lambda do
      SyspaySDK::Entities::ReturnedEntity.build_from_response({ test: "test" })
    end.should raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end
end