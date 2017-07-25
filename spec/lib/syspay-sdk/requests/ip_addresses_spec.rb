describe SyspaySDK::Requests::IpAddresses do
  it "is a SyspaySDK::Requests::BaseClass" do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      expect(described_class::METHOD).to eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/system-ip/'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/system-ip/')
    end
  end

  it { is_expected.to respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        subject.build_response("test")
      }.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain ip_addresses" do
      expect {
        subject.build_response({test: "test"})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if ip_addresses is not an array" do
      expect {
        subject.build_response({ip_addresses: {}})
      }.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::BillingAgreement" do
      expect(subject.build_response({ ip_addresses: [] })).to be_a(Array)
    end
  end
end
