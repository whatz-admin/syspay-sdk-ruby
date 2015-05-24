require 'spec_helper'

describe SyspaySDK::Entities::PaymentMethod do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'payment_method'" do
      SyspaySDK::Entities::PaymentMethod::TYPE.should eq('payment_method')
    end

    it "has a TYPE_CREDITCARD class constant set to 'CREDITCARD'" do
      SyspaySDK::Entities::PaymentMethod::TYPE_CREDITCARD.should eq('CREDITCARD')
    end

    it "has a TYPE_PAYSAFECARD class constant set to 'PAYSAFECARD'" do
      SyspaySDK::Entities::PaymentMethod::TYPE_PAYSAFECARD.should eq('PAYSAFECARD')
    end

    it "has a TYPE_CLICKANDBUY class constant set to 'CLICKANDBUY'" do
      SyspaySDK::Entities::PaymentMethod::TYPE_CLICKANDBUY.should eq('CLICKANDBUY')
    end

    it "has a TYPE_POSTFINANCE class constant set to 'POSTFINANCE'" do
      SyspaySDK::Entities::PaymentMethod::TYPE_POSTFINANCE.should eq('POSTFINANCE')
    end

    it "has a TYPE_IDEAL class constant set to 'IDEAL'" do
      SyspaySDK::Entities::PaymentMethod::TYPE_IDEAL.should eq('IDEAL')
    end
  end

  describe "Attributes" do
    it { should respond_to(:type) }
    it { should respond_to(:display) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::PaymentMethod.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a PaymentMethod object" do
      SyspaySDK::Entities::PaymentMethod.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::PaymentMethod)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::PaymentMethod.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      {
        type: "type",
        display: "display"
      }
    end

    before(:each) do
      @payment_method = SyspaySDK::Entities::PaymentMethod.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @payment_method.raw.should eq(response)
    end

    it "sets instance type attribute using value in response" do
      @payment_method.type.should eq(response[:type])
    end

    it "sets instance display attribute using value in response" do
      @payment_method.display.should eq(response[:display])
    end
  end
end
