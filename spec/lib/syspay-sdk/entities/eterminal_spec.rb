require 'spec_helper'

describe SyspaySDK::Entities::Eterminal do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'eterminal'" do
      SyspaySDK::Entities::Eterminal::TYPE.should eq('eterminal')
    end
  end

  describe "Attributes" do
    it { should respond_to(:url) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::Eterminal.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a Eterminal object" do
      SyspaySDK::Entities::Eterminal.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::Eterminal)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::Eterminal.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      { url: "url" }
    end

    before(:each) do
      @eterminal = SyspaySDK::Entities::Eterminal.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @eterminal.raw.should eq(response)
    end

    it "sets instance email attribute using value in response" do
      @eterminal.url.should eq(response[:url])
    end
  end
end
