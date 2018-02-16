describe SyspaySDK::Entities::ReturnedEntity do
  it "is a SyspaySDK::Entities::BaseClass" do
    is_expected.to be_a(SyspaySDK::Entities::BaseClass)
  end

  it "responds to build_from_response" do
    expect(described_class).to respond_to(:build_from_response)
  end

  it "raises an error when build_from_response method is not implemented" do
    expect {
      described_class.build_from_response({ test: "test" })
    }.to raise_error(SyspaySDK::Exceptions::NotImplementedError)
  end
end