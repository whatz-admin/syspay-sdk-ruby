require 'spec_helper'

describe SyspaySDK::Requests::AstroPayBank do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      SyspaySDK::Requests::AstroPayBank::METHOD.should eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/astropay/banks/'" do
      SyspaySDK::Requests::AstroPayBank::PATH.should eq('/api/v1/merchant/astropay/banks/')
    end
  end

  describe "Attributes" do
    it { should respond_to(:country) }
  end

  describe "Initialize" do
    it "can be initialized with a country parameter" do
      astro_pay_bank = SyspaySDK::Requests::AstroPayBank.new "test_country"
      astro_pay_bank.country.should eq("test_country")
    end

    it "can be initialized without arguments" do
      astro_pay_bank = SyspaySDK::Requests::AstroPayBank.new
      astro_pay_bank.country.should be_nil
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::AstroPayBank::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_method" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::AstroPayBank::PATH)
    end
    it "returns the PATH constant with country if exists" do
      with_country = SyspaySDK::Requests::AstroPayBank.new "test_country"
      with_country.get_path.should eq("#{SyspaySDK::Requests::AstroPayBank::PATH}test_country")
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain banks" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an Array" do
      subject.build_response({ banks: [] }).should be_a(Array)
    end

    let(:data) do
      {
        banks: [
          {id: 1},
          {id: 2}
        ]
      }
    end

    it "returns an Array of SyspaySDK::Entities::AstroPayBank" do
      subject.build_response(data).count.should eq(2)
      subject.build_response(data).first.should be_a(SyspaySDK::Entities::AstroPayBank)
    end
  end
end

# <?php
# /**
#  * Get the available banks to process AstroPay payments with.
#  */
# class Syspay_Merchant_AstroPayBanksRequest extends Syspay_Merchant_Request
# {
#     public function getMethod()
#     {
#         return self::METHOD;
#     }
#     /**
#      * {@inheritDoc}
#      */
#     public function getPath()
#     {
#         return sprintf(self::PATH, $this->country);
#     }
#     /**
#      * {@inheritDoc}
#      */
#     public function buildResponse(stdClass $response)
#     {
#         if (!isset($response->banks) || !is_array($response->banks)) {
#             throw new Syspay_Merchant_UnexpectedResponseException(
#                 'Unable to retrieve "banks" data from response',
#                 $response
#             );
#         }
#         $banks = array();
#         foreach ($response->banks as $bank) {
#             array_push(
#                 $banks,
#                 Syspay_Merchant_Entity_AstroPayBank::buildFromResponse($bank)
#             );
#         }
#         return $banks;
#     }
#     /**
#      * Gets the value of country.
#      *
#      * @return string
#      */
#     public function getCountry()
#     {
#         return $this->country;
#     }
#     /**
#      * Sets the value of country.
#      *
#      * @param string $country the country
#      *
#      * @return self
#      */
#     public function setCountry($country)
#     {
#         $this->country = strtoupper($country);
#         return $this;
#     }
# }