describe SyspaySDK::Redirect do
  it { is_expected.to respond_to(:syspay_id) }
  it { is_expected.to respond_to(:syspay_passphrase) }
  it { is_expected.to respond_to(:skip_auth_check) }

  describe "Initialize" do
    it "assigns the values set in configuration and sets skip_auth_check to false by default" do
      request = SyspaySDK::Redirect.new

      expect(request.syspay_id).to eq(SyspaySDK::Config.config.syspay_id)
      expect(request.syspay_passphrase).to eq(SyspaySDK::Config.config.syspay_passphrase)
      expect(request.skip_auth_check).to eq(false)
    end

    it "assigns skip_auth_check to the given value" do
      request = SyspaySDK::Redirect.new true

      expect(request.skip_auth_check).to eq(true)
    end
  end

  describe "#validate_checksum" do
    it "raises a SyspaySDK::Exceptions::MissingArgumentError when one of the three parameters is not set" do
      expect {
        subject.validate_checksum(nil, "test", "test")
      }.to raise_error(SyspaySDK::Exceptions::MissingArgumentError)

      expect {
        subject.validate_checksum("test", nil, "test")
      }.to raise_error(SyspaySDK::Exceptions::MissingArgumentError)

      expect {
        subject.validate_checksum("test", "test", nil)
      }.to raise_error(SyspaySDK::Exceptions::MissingArgumentError)
    end

    it "raises a SyspaySDK::Exceptions::InvalidChecksumError when the checksum doesn't match" do
      result = "test"
      passphrase = "test"
      checksum = "test"

      expect {
        subject.validate_checksum(result, passphrase, checksum)
      }.to raise_error(SyspaySDK::Exceptions::InvalidChecksumError)
    end

    it "doesn't raise any error when the checksum matches" do
      result = "test"
      passphrase = "test"

      checksum = Digest::SHA1.hexdigest("#{result}#{passphrase}")

      expect {
        subject.validate_checksum(result, passphrase, checksum)
      }.not_to raise_error
    end
  end

  describe "#get_result" do
    let (:source) do
      {
        result: "test!",
        merchant: SyspaySDK::Config.config.syspay_id,
        checksum: "testmerchant",
      }
    end
    it "calls validate_checksum when skip_auth_check is set to false" do
      decoded_result = double :decoded_result

      expect(Base64).to receive(:strict_decode64).with(source[:result]).and_return(decoded_result)
      expect(JSON).to receive(:parse).with(decoded_result).and_return({payment: {} })
      expect(subject).to receive(:validate_checksum).with(source[:result], subject.syspay_passphrase, source[:checksum])

      subject.skip_auth_check = false
      subject.get_result(source)
    end

    describe "When skip_auth_check is true" do
      before(:each) do
        subject.skip_auth_check = true
      end

      it "calls Base64.strict_decode64 passing it the result" do
        expect(Base64).to receive(:strict_decode64).with(source[:result])
        expect(JSON).to receive(:parse).with(anything()).and_return({payment: {} })

        subject.get_result(source)
      end

      it "raises a SyspaySDK::Exceptions::InvalidArgumentError when the Base64.strict_decode64 raises an ArgumentError" do
        expect(Base64).to receive(:strict_decode64).with(source[:result]) { raise ArgumentError }

        expect {
          subject.get_result(source)
        }.to raise_error(SyspaySDK::Exceptions::InvalidArgumentError)
      end

      it "calls JSON.parse on result" do
        str = "string"

        expect(Base64).to receive(:strict_decode64).with(source[:result]).and_return(str)
        expect(JSON).to receive(:parse).with(str).and_return({payment: {} })

        subject.get_result(source)
      end

      it "raises a SyspaySDK::Exceptions::InvalidArgumentError when JSON.parse raises a JSON::ParserError" do
        str = "string"

        expect(Base64).to receive(:strict_decode64).with(source[:result]).and_return(str)
        expect(JSON).to receive(:parse).with(str) { raise JSON::ParserError }

        expect {
          subject.get_result(source)
        }.to raise_error(SyspaySDK::Exceptions::InvalidArgumentError)
      end

      it "raises a SyspaySDK::Exceptions::InvalidArgumentError when to_json return value doesn't contain the payment hash" do
        str = "string"
        expect(Base64).to receive(:strict_decode64).with(source[:result]).and_return(str)
        expect(JSON).to receive(:parse).with(str).and_return( { } )

        expect {
          subject.get_result(source)
        }.to raise_error(SyspaySDK::Exceptions::InvalidArgumentError)
      end

      it "returns a SyspaySDK::Entities::Payment when everything went fine" do
        str = "anything"

        expect(Base64).to receive(:strict_decode64).with(source[:result]).and_return(str)
        expect(JSON).to receive(:parse).with(str).and_return( { payment: {id: 1} } )

        expect(subject.get_result(source)).to be_a(SyspaySDK::Entities::Payment)
      end
    end
  end
end
