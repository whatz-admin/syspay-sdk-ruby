require "spec_helper"

describe SyspaySDK::Entities::SubscriptionEvent do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'subscription_event'" do
      SyspaySDK::Entities::SubscriptionEvent::TYPE.should eq('subscription_event')
    end
    it "has a TYPE_TRIAL class constant set to 'TRIAL'" do
        SyspaySDK::Entities::SubscriptionEvent::TYPE_TRIAL.should eq('TRIAL')
    end

    it "has a TYPE_FREE_TRIAL class constant set to 'FREE_TRIAL'" do
        SyspaySDK::Entities::SubscriptionEvent::TYPE_FREE_TRIAL.should eq('FREE_TRIAL')
    end

    it "has a TYPE_INITIAL class constant set to 'INITIAL'" do
        SyspaySDK::Entities::SubscriptionEvent::TYPE_INITIAL.should eq('INITIAL')
    end

    it "has a TYPE_BILL class constant set to 'BILL'" do
        SyspaySDK::Entities::SubscriptionEvent::TYPE_BILL.should eq('BILL')
    end

    it "has a TYPE_END class constant set to 'END'" do
        SyspaySDK::Entities::SubscriptionEvent::TYPE_END.should eq('END')
    end
  end

  describe "Attributes" do
    it { should respond_to(:scheduled_date) }
    it { should respond_to(:event_type) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::SubscriptionEvent.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a SubscriptionEvent object" do
      SyspaySDK::Entities::SubscriptionEvent.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::SubscriptionEvent)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::SubscriptionEvent.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      { event_type: "event_type" }
    end

    before(:each) do
      @subscription_event = SyspaySDK::Entities::SubscriptionEvent.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @subscription_event.raw.should eq(response)
    end

    it "sets instance event_type attribute using value in response" do
      @subscription_event.event_type.should eq(response[:event_type])
    end

    it "sets instance scheduled_date attribute using value in response" do
      scheduled_date = DateTime.new(2001,2,3)
      response[:scheduled_date] = scheduled_date.to_time.to_i
      SyspaySDK::Entities::SubscriptionEvent.build_from_response(response).scheduled_date.should eq(scheduled_date)
    end
  end
end
