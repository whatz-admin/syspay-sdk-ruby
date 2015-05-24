require "spec_helper"

describe SyspaySDK::Entities::Refund do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'refund'" do
      SyspaySDK::Entities::Refund::TYPE.should eq('refund')
    end
  end

  describe "Attributes" do
    it { should respond_to(:id) }
    it { should respond_to(:status) }
    it { should respond_to(:reference) }
    it { should respond_to(:amount) }
    it { should respond_to(:currency) }
    it { should respond_to(:description) }
    it { should respond_to(:extra) }
    it { should respond_to(:payment) }
    it { should respond_to(:processing_time) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::Refund.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a Refund object" do
      SyspaySDK::Entities::Refund.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::Refund)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::Refund.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      {
        id: "id",
        status: "status",
        reference: "reference",
        amount: "amount",
        currency: "currency",
        description: "description",
        extra: "extra"
      }
    end

    before(:each) do
      @refund = SyspaySDK::Entities::Refund.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @refund.raw.should eq(response)
    end

    it "sets instance id attribute using value in response" do
      @refund.id.should eq(response[:id])
    end

    it "sets intance id attribute using value in response" do
      @refund.id.should eq(response[:id])
    end

    it "sets intance status attribute using value in response" do
      @refund.status.should eq(response[:status])
    end

    it "sets intance reference attribute using value in response" do
      @refund.reference.should eq(response[:reference])
    end

    it "sets intance amount attribute using value in response" do
      @refund.amount.should eq(response[:amount])
    end

    it "sets intance currency attribute using value in response" do
      @refund.currency.should eq(response[:currency])
    end

    it "sets intance description attribute using value in response" do
      @refund.description.should eq(response[:description])
    end

    it "sets intance extra attribute using value in response" do
      @refund.extra.should eq(response[:extra])
    end

    it "sets instance processing_time attribute using value in response" do
      processing_time = DateTime.new(2001,2,3)
      response[:processing_time] = processing_time.to_time.to_i
      SyspaySDK::Entities::Refund.build_from_response(response).processing_time.should eq(processing_time)
    end

    it "sets instance payment attribute using value in response"do
      response[:payment] = {}
      SyspaySDK::Entities::Refund.build_from_response(response).payment.should be_a(SyspaySDK::Entities::Payment)
    end
  end
end