require 'spec_helper'

describe SyspaySDK::Entities::Subscription do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'subscription'" do
      SyspaySDK::Entities::Subscription::TYPE.should eq('subscription')
    end

    it "has a STATUS_PENDING class constant set to 'PENDING'" do
      SyspaySDK::Entities::Subscription::STATUS_PENDING.should eq('PENDING')
    end

    it "has a STATUS_ACTIVE class constant set to 'ACTIVE'" do
      SyspaySDK::Entities::Subscription::STATUS_ACTIVE.should eq('ACTIVE')
    end

    it "has a STATUS_CANCELLED class constant set to 'CANCELLED'" do
      SyspaySDK::Entities::Subscription::STATUS_CANCELLED.should eq('CANCELLED')
    end

    it "has a STATUS_ENDED class constant set to 'ENDED'" do
      SyspaySDK::Entities::Subscription::STATUS_ENDED.should eq('ENDED')
    end

    it "has a PHASE_NEW class constant set to 'NEW'" do
      SyspaySDK::Entities::Subscription::PHASE_NEW.should eq('NEW')
    end

    it "has a PHASE_TRIAL class constant set to 'TRIAL'" do
      SyspaySDK::Entities::Subscription::PHASE_TRIAL.should eq('TRIAL')
    end

    it "has a PHASE_BILLING class constant set to 'BILLING'" do
      SyspaySDK::Entities::Subscription::PHASE_BILLING.should eq('BILLING')
    end

    it "has a PHASE_RETRY class constant set to 'RETRY'" do
      SyspaySDK::Entities::Subscription::PHASE_RETRY.should eq('RETRY')
    end

    it "has a PHASE_LAST class constant set to 'LAST'" do
      SyspaySDK::Entities::Subscription::PHASE_LAST.should eq('LAST')
    end

    it "has a PHASE_CLOSED class constant set to 'CLOSED'" do
      SyspaySDK::Entities::Subscription::PHASE_CLOSED.should eq('CLOSED')
    end

    it "has a END_REASON_UNSUBSCRIBED_MERCHANT class constant set to 'UNSUBSCRIBED_MERCHANT'" do
      SyspaySDK::Entities::Subscription::END_REASON_UNSUBSCRIBED_MERCHANT.should eq('UNSUBSCRIBED_MERCHANT')
    end

    it "has a END_REASON_UNSUBSCRIBED_ADMIN class constant set to 'UNSUBSCRIBED_ADMIN'" do
      SyspaySDK::Entities::Subscription::END_REASON_UNSUBSCRIBED_ADMIN.should eq('UNSUBSCRIBED_ADMIN')
    end

    it "has a END_REASON_SUSPENDED_ATTEMPTS class constant set to 'SUSPENDED_ATTEMPTS'" do
      SyspaySDK::Entities::Subscription::END_REASON_SUSPENDED_ATTEMPTS.should eq('SUSPENDED_ATTEMPTS')
    end

    it "has a END_REASON_SUSPENDED_EXPIRED class constant set to 'SUSPENDED_EXPIRED'" do
      SyspaySDK::Entities::Subscription::END_REASON_SUSPENDED_EXPIRED.should eq('SUSPENDED_EXPIRED')
    end

    it "has a END_REASON_SUSPENDED_CHARGEBACK class constant set to 'SUSPENDED_CHARGEBACK'" do
      SyspaySDK::Entities::Subscription::END_REASON_SUSPENDED_CHARGEBACK.should eq('SUSPENDED_CHARGEBACK')
    end

    it "has a END_REASON_COMPLETE class constant set to 'COMPLETE'" do
      SyspaySDK::Entities::Subscription::END_REASON_COMPLETE.should eq('COMPLETE')
    end
  end

  describe "Attributes" do
    it { should respond_to(:id) }
    it { should respond_to(:created) }
    it { should respond_to(:start_date) }
    it { should respond_to(:end_date) }
    it { should respond_to(:status) }
    it { should respond_to(:phase) }
    it { should respond_to(:end_reason) }
    it { should respond_to(:payment_method) }
    it { should respond_to(:website) }
    it { should respond_to(:ems_url) }
    it { should respond_to(:redirect_url) }
    it { should respond_to(:plan) }
    it { should respond_to(:customer) }
    it { should respond_to(:plan_id) }
    it { should respond_to(:plan_type) }
    it { should respond_to(:extra) }
    it { should respond_to(:reference) }
    it { should respond_to(:redirect) }
    it { should respond_to(:next_event) }
  end

  it "responds to ::build_from_response" do
    SyspaySDK::Entities::Subscription.should respond_to(:build_from_response)
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::Subscription.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a Payment object" do
      SyspaySDK::Entities::Subscription.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::Subscription)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::Subscription.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      {
        id: "id",
        plan_id: "plan_id",
        plan_type: "plan_type",
        reference: "reference",
        status: "status",
        phase: "phase",
        extra: "extra",
        ems_url: "ems_url",
        end_reason: "end_reason"
      }
    end

    before(:each) do
      @subscription = SyspaySDK::Entities::Subscription.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @subscription.raw.should eq(response)
    end

    it "sets instance id attribute using value in response" do
      @subscription.id.should eq(response[:id])
    end

    it "sets instance plan_id attribute using value in response" do
      @subscription.plan_id.should eq(response[:plan_id])
    end

    it "sets instance plan_type attribute using value in response" do
      @subscription.plan_type.should eq(response[:plan_type])
    end

    it "sets instance reference attribute using value in response" do
      @subscription.reference.should eq(response[:reference])
    end

    it "sets instance status attribute using value in response" do
      @subscription.status.should eq(response[:status])
    end

    it "sets instance phase attribute using value in response" do
      @subscription.phase.should eq(response[:phase])
    end

    it "sets instance extra attribute using value in response" do
      @subscription.extra.should eq(response[:extra])
    end

    it "sets instance ems_url attribute using value in response" do
      @subscription.ems_url.should eq(response[:ems_url])
    end

    it "sets instance end_reason attribute using value in response" do
      @subscription.end_reason.should eq(response[:end_reason])
    end

    it "sets instance created attribute using value in response" do
      created = DateTime.new(2001,2,3)
      response[:created] = created.to_time.to_i
      SyspaySDK::Entities::Subscription.build_from_response(response).created.should eq(created)
    end

    it "sets instance start_date attribute using value in response" do
      start_date = DateTime.new(2001,2,3)
      response[:start_date] = start_date.to_time.to_i
      SyspaySDK::Entities::Subscription.build_from_response(response).start_date.should eq(start_date)
    end

    it "sets instance end_date attribute using value in response" do
      end_date = DateTime.new(2001,2,3)
      response[:end_date] = end_date.to_time.to_i
      SyspaySDK::Entities::Subscription.build_from_response(response).end_date.should eq(end_date)
    end

    it "sets instance paymentMethod attribute using value in response" do
      response[:payment_method] = {}
      SyspaySDK::Entities::Subscription.build_from_response(response).payment_method.should be_a(SyspaySDK::Entities::PaymentMethod)
    end

    it "sets instance customer attribute using value in response" do
      response[:customer] = {}
      SyspaySDK::Entities::Subscription.build_from_response(response).customer.should be_a(SyspaySDK::Entities::Customer)
    end

    it "sets instance plan attribute using value in response" do
      response[:plan] = {}
      SyspaySDK::Entities::Subscription.build_from_response(response).plan.should be_a(SyspaySDK::Entities::Plan)
    end

    it "sets instance next_event attribute using value in response" do
      response[:next_event] = {}
      SyspaySDK::Entities::Subscription.build_from_response(response).next_event.should be_a(SyspaySDK::Entities::SubscriptionEvent)
    end
  end
end
