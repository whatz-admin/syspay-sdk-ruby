require "spec_helper"

describe SyspaySDK::Redirect do
  it { should respond_to(:syspay_id) }
  it { should respond_to(:syspay_passphrase) }
  it { should respond_to(:skip_auth_check) }

  describe "Initialize" do
    it "assigns the values set in configuration and sets skip_auth_check to false by default" do
      request = SyspaySDK::Redirect.new
      request.syspay_id.should eq(Config.config.syspay_id)
      request.syspay_passphrase.should eq(Config.config.syspay_passphrase)
      request.skip_auth_check.should eq(false)
    end
    it "assigns skip_auth_check to the given value" do
      request = SyspaySDK::Redirect.new true
      request.skip_auth_check.should eq(true)
    end
  end

  it { should respond_to(:validate_checksum) }

  describe "#validate_checksum" do
    it "raises a SyspaySDK::Exceptions::MissingArgumentError when one of the three parameters is not set"
  end

  it { should respond_to(:get_result) }

  describe "#get_result" do
    let (:source) do
      {
        result: "test!",
        merchant: SyspaySDK::Config.config.syspay_id,
        checksum: "testmerchant",
      }
    end

    it "calls validate_checksum when skip_auth_check is set to false" do
      Base64.should receive(:strict_decode64).with(anything())
      JSON.should receive(:parse).with(anything()).and_return({payment: {} })
      subject.skip_auth_check = false
      subject.should receive(:validate_checksum).with(source[:result], source[:merchant], source[:checksum])
      subject.get_result(source)
    end

    before(:each) do
      subject.skip_auth_check = true
    end

    it "calls Base64.strict_decode64 passing it the result" do
      Base64.should receive(:strict_decode64).with(source[:result])
      JSON.should receive(:parse).with(anything()).and_return({payment: {} })
      subject.get_result(source)
    end

    it "raises a SyspaySDK::Exceptions::InvalidArgumentError when the Base64.strict_decode64 raises an ArgumentError" do
      Base64.should receive(:strict_decode64).with(source[:result]) { raise ArgumentError }
      lambda do
        subject.get_result(source)
      end.should raise_error(SyspaySDK::Exceptions::InvalidArgumentError)
    end

    it "calls JSON.parse on result" do
      str = "string"
      Base64.should receive(:strict_decode64).with(source[:result]).and_return(str)
      JSON.should receive(:parse).with(str).and_return({payment: {} })
      subject.get_result(source)
    end

    it "raises a SyspaySDK::Exceptions::InvalidArgumentError when JSON.parse raises a JSON::ParserError" do
      str = "string"
      Base64.should receive(:strict_decode64).with(source[:result]).and_return(str)
      JSON.should receive(:parse).with(str) { raise JSON::ParserError }
      lambda do
        subject.get_result(source)
      end.should raise_error(SyspaySDK::Exceptions::InvalidArgumentError)
    end

    it "raises a SyspaySDK::Exceptions::InvalidArgumentError when to_json return value doesn't contain the payment hash" do
      str = "string"
      Base64.should receive(:strict_decode64).with(source[:result]).and_return(str)
      JSON.should receive(:parse).with(str).and_return( { } )
      lambda do
        subject.get_result(source)
      end.should raise_error(SyspaySDK::Exceptions::InvalidArgumentError)
    end

    it "returns a SyspaySDK::Entities::Payment when everything went fine" do
      str = "anything"
      Base64.should receive(:strict_decode64).with(source[:result]).and_return(str)
      JSON.should receive(:parse).with(str).and_return( { payment: {id: 1} } )
      subject.get_result(source).should be_a(SyspaySDK::Entities::Payment)
    end
  end
end
# <?php
# /**
#  * Handle Redirections
#  */
# class Syspay_Merchant_Redirect
# {
#     public function getResult(array $source)
#     {
#         $result   = isset($source['result'])?$source['result']:null;
#         $merchant = isset($source['merchant'])?$source['merchant']:null;
#         $checksum = isset($source['checksum'])?$source['checksum']:null;

#         if (!$this->skipAuthCheck) {
#             $this->checkChecksum($result, $merchant, $checksum);
#         }

#         $result = base64_decode($result);
#         if ($result === false) {
#             throw new Syspay_Merchant_RedirectException(
#                 'Unable to decode the result parameter',
#                 Syspay_Merchant_RedirectException::CODE_INVALID_CONTENT
#             );
#         }

#         $result = json_decode($result);
#         if ($result === null || empty($result->payment)) {
#             throw new Syspay_Merchant_RedirectException(
#                 'Unable to decode the result parameter',
#                 Syspay_Merchant_RedirectException::CODE_INVALID_CONTENT
#             );
#         }

#         return Syspay_Merchant_Entity_Payment::buildFromResponse($result->payment);
#     }

#     /**
#      * Validate the request's checksum
#      * @throws Syspay_Merchant_RedirectException If the checksum didn't validate
#      */
#     private function checkChecksum($result, $merchant, $checksum)
#     {
#         if (empty($merchant) || empty($checksum) || empty($result)) {
#             throw new Syspay_Merchant_RedirectException(
#                 'Missing parameter',
#                 Syspay_Merchant_RedirectException::CODE_MISSING_PARAM
#             );
#         }
#         if (empty($this->secrets[$merchant])) {
#             throw new Syspay_Merchant_RedirectException(
#                 'Unknown merchant: ' . $merchant,
#                 Syspay_Merchant_RedirectException::CODE_UNKNOWN_MERCHANT
#             );
#         }
#         if (!Syspay_Merchant_Utils::checkChecksum($result, $this->secrets[$merchant], $checksum)) {
#             throw new Syspay_Merchant_RedirectException(
#                 'Invalid checksum',
#                 Syspay_Merchant_RedirectException::CODE_INVALID_CHECKSUM
#             );
#         }
#     }
# }