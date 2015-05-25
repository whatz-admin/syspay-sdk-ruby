require 'spec_helper'

describe SyspaySDK::Requests::PlanUpdate do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'PUT'" do
      SyspaySDK::Requests::PlanUpdate::METHOD.should eq('PUT')
    end

    it "has a PATH class constant set to '/api/v1/merchant/plan/'" do
      SyspaySDK::Requests::PlanUpdate::PATH.should eq('/api/v1/merchant/plan/')
    end
  end

  describe "Attributes" do
    it { should respond_to(:plan_id) }
    it { should respond_to(:trial_amount) }
    it { should respond_to(:initial_amount) }
    it { should respond_to(:billing_amount) }
  end

  describe "Initialize" do
    it "can be initialized with a plan_id parameter" do
      plan_update = SyspaySDK::Requests::PlanUpdate.new "id"
      plan_update.plan_id.should eq("id")
    end

    it "can be initialized without arguments" do
      plan_update = SyspaySDK::Requests::PlanUpdate.new
      plan_update.plan_id.should be_nil
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::PlanUpdate::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::PlanUpdate::PATH)
    end
    it "returns the PATH constant with plan_id if exists" do
      with_plan_id = SyspaySDK::Requests::PlanUpdate.new
      with_plan_id.plan_id = "test_plan_id"
      with_plan_id.get_path.should eq("#{SyspaySDK::Requests::PlanUpdate::PATH}test_plan_id")
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the plan" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Plan" do
      subject.build_response({ plan: {} }).should be_a(SyspaySDK::Entities::Plan)
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    describe "the returned hash" do
      it "contains the plan_id" do
        subject.plan_id = "plan_id"
        subject.get_data.should include(plan_id: "plan_id")
      end

      it "contains the trial_amount" do
        subject.trial_amount = "trial_amount"
        subject.get_data.should include(trial_amount: "trial_amount")
      end

      it "contains the initial_amount" do
        subject.initial_amount = "initial_amount"
        subject.get_data.should include(initial_amount: "initial_amount")
      end

      it "contains the billing_amount" do
        subject.billing_amount = "billing_amount"
        subject.get_data.should include(billing_amount: "billing_amount")
      end
    end
  end
end
