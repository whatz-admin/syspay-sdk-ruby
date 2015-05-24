require 'spec_helper'

describe SyspaySDK::Entities::Plan do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'plan'" do
      SyspaySDK::Entities::Plan::TYPE.should eq('plan')
    end

    it "has a UNIT_MINUTE class constant set to 'minute'" do
      SyspaySDK::Entities::Plan::UNIT_MINUTE.should eq('minute')
    end

    it "has a UNIT_HOUR class constant set to 'hour'" do
      SyspaySDK::Entities::Plan::UNIT_HOUR.should eq('hour')
    end

    it "has a UNIT_DAY class constant set to 'day'" do
      SyspaySDK::Entities::Plan::UNIT_DAY.should eq('day')
    end

    it "has a UNIT_WEEK class constant set to 'week'" do
      SyspaySDK::Entities::Plan::UNIT_WEEK.should eq('week')
    end

    it "has a UNIT_MONTH class constant set to 'month'" do
      SyspaySDK::Entities::Plan::UNIT_MONTH.should eq('month')
    end

    it "has a UNIT_YEAR class constant set to 'year'" do
      SyspaySDK::Entities::Plan::UNIT_YEAR.should eq('year')
    end

    it "has a TYPE_SUBSCRIPTION class constant set to 'SUBSCRIPTION'" do
      SyspaySDK::Entities::Plan::TYPE_SUBSCRIPTION.should eq('SUBSCRIPTION')
    end

    it "has a TYPE_INSTALMENT class constant set to 'INSTALMENT'" do
      SyspaySDK::Entities::Plan::TYPE_INSTALMENT.should eq('INSTALMENT')
    end
  end

  describe "Attributes" do
    it { should respond_to(:id) }
    it { should respond_to(:created) }
    it { should respond_to(:status) }
    it { should respond_to(:type) }
    it { should respond_to(:name) }
    it { should respond_to(:description) }
    it { should respond_to(:currency) }
    it { should respond_to(:trial_amount) }
    it { should respond_to(:trial_period) }
    it { should respond_to(:trial_period_unit) }
    it { should respond_to(:trial_cycles) }
    it { should respond_to(:initial_amount) }
    it { should respond_to(:billing_amount) }
    it { should respond_to(:billing_period) }
    it { should respond_to(:billing_period_unit) }
    it { should respond_to(:billing_cycles) }
    it { should respond_to(:retry_map_id) }
    it { should respond_to(:total_amount) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::Plan.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a Plan object" do
      SyspaySDK::Entities::Plan.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::Plan)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::Plan.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      {
        id: "id",
        status: "status",
        name: "name",
        description: "description",
        currency: "currency",
        trial_amount: "trial_amount",
        trial_period: "trial_period",
        trial_period_unit: "trial_period_unit",
        trial_cycles: "trial_cycles",
        billing_amount: "billing_amount",
        billing_period: "billing_period",
        billing_period_unit: "billing_period_unit",
        billing_cycles: "billing_cycles",
        initial_amount: "initial_amount",
        retry_map_id: "retry_map_id",
        type: "type"
      }
    end

    before(:each) do
      @plan = SyspaySDK::Entities::Plan.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @plan.raw.should eq(response)
    end

    it "sets instance id attribute using value in response" do
      @plan.id.should eq(response[:id])
    end

    it "sets instance status attribute using value in response" do
      @plan.status.should eq(response[:status])
    end

    it "sets instance name attribute using value in response" do
      @plan.name.should eq(response[:name])
    end

    it "sets instance description attribute using value in response" do
      @plan.description.should eq(response[:description])
    end

    it "sets instance currency attribute using value in response" do
      @plan.currency.should eq(response[:currency])
    end

    it "sets instance trial_amount attribute using value in response" do
      @plan.trial_amount.should eq(response[:trial_amount])
    end

    it "sets instance trial_period attribute using value in response" do
      @plan.trial_period.should eq(response[:trial_period])
    end

    it "sets instance trial_period_unit attribute using value in response" do
      @plan.trial_period_unit.should eq(response[:trial_period_unit])
    end

    it "sets instance trial_cycles attribute using value in response" do
      @plan.trial_cycles.should eq(response[:trial_cycles])
    end

    it "sets instance billing_amount attribute using value in response" do
      @plan.billing_amount.should eq(response[:billing_amount])
    end

    it "sets instance billing_period attribute using value in response" do
      @plan.billing_period.should eq(response[:billing_period])
    end

    it "sets instance billing_period_unit attribute using value in response" do
      @plan.billing_period_unit.should eq(response[:billing_period_unit])
    end

    it "sets instance billing_cycles attribute using value in response" do
      @plan.billing_cycles.should eq(response[:billing_cycles])
    end

    it "sets instance initial_amount attribute using value in response" do
      @plan.initial_amount.should eq(response[:initial_amount])
    end

    it "sets instance retry_map_id attribute using value in response" do
      @plan.retry_map_id.should eq(response[:retry_map_id])
    end

    it "sets instance type attribute using value in response" do
      @plan.type.should eq(response[:type])
    end

    it "sets instance created attribute using value in response" do
      created = DateTime.new(2001,2,3)
      response[:created] = created.to_time.to_i
      SyspaySDK::Entities::Plan.build_from_response(response).created.should eq(created)
    end
  end
end
