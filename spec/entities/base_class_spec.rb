require 'spec_helper'

describe SyspaySDK::Entities::BaseClass do
  it "responds to raw" do
    subject.should respond_to(:raw)
  end

  it "responds to #to_hash" do
    subject.should respond_to(:to_hash)
  end

  it "responds to get_type" do
    subject.should respond_to(:get_type)
  end
end
