require 'spec_helper'

describe SyspaySDK::Requests::PlanInfo do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      SyspaySDK::Requests::PlanInfo::METHOD.should eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/plan/'" do
      SyspaySDK::Requests::PlanInfo::PATH.should eq('/api/v1/merchant/plan/')
    end
  end

  describe "Attributes" do
    it { should respond_to(:plan_id) }
  end

  describe "Initialize" do
    it "can be initialized with a plan_id parameter" do
      plan_info = SyspaySDK::Requests::PlanInfo.new "id"
      plan_info.plan_id.should eq("id")
    end

    it "can be initialized without arguments" do
      plan_info = SyspaySDK::Requests::PlanInfo.new
      plan_info.plan_id.should be_nil
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::PlanInfo::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::PlanInfo::PATH)
    end
    it "returns the PATH constant with plan_id if exists" do
      with_plan_id = SyspaySDK::Requests::PlanInfo.new
      with_plan_id.plan_id = "test_plan_id"
      with_plan_id.get_path.should eq("#{SyspaySDK::Requests::PlanInfo::PATH}test_plan_id")
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain plan" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Plan" do
      subject.build_response({ plan: {} }).should be_a(SyspaySDK::Entities::Plan)
    end
  end
end
