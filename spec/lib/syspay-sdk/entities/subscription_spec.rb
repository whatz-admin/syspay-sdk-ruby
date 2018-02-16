require 'spec_helper'

describe SyspaySDK::Entities::Subscription do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'subscription'" do
      expect(described_class::TYPE).to eq('subscription')
    end

    describe "STATUS" do
      it "has a STATUS_PENDING class constant set to 'PENDING'" do
        expect(described_class::STATUS_PENDING).to eq('PENDING')
      end

      it "has a STATUS_ACTIVE class constant set to 'ACTIVE'" do
        expect(described_class::STATUS_ACTIVE).to eq('ACTIVE')
      end

      it "has a STATUS_CANCELLED class constant set to 'CANCELLED'" do
        expect(described_class::STATUS_CANCELLED).to eq('CANCELLED')
      end

      it "has a STATUS_ENDED class constant set to 'ENDED'" do
        expect(described_class::STATUS_ENDED).to eq('ENDED')
      end

      it "has a STATUS_TERMINATED class constant set to 'TERMINATED'" do
        expect(described_class::STATUS_TERMINATED).to eq('TERMINATED')
      end
    end


    it "has a PHASE_NEW class constant set to 'NEW'" do
      expect(described_class::PHASE_NEW).to eq('NEW')
    end

    it "has a PHASE_TRIAL class constant set to 'TRIAL'" do
      expect(described_class::PHASE_TRIAL).to eq('TRIAL')
    end

    it "has a PHASE_BILLING class constant set to 'BILLING'" do
      expect(described_class::PHASE_BILLING).to eq('BILLING')
    end

    it "has a PHASE_RETRY class constant set to 'RETRY'" do
      expect(described_class::PHASE_RETRY).to eq('RETRY')
    end

    it "has a PHASE_LAST class constant set to 'LAST'" do
      expect(described_class::PHASE_LAST).to eq('LAST')
    end

    it "has a PHASE_CLOSED class constant set to 'CLOSED'" do
      expect(described_class::PHASE_CLOSED).to eq('CLOSED')
    end

    it "has a END_REASON_UNSUBSCRIBED_MERCHANT class constant set to 'UNSUBSCRIBED_MERCHANT'" do
      expect(described_class::END_REASON_UNSUBSCRIBED_MERCHANT).to eq('UNSUBSCRIBED_MERCHANT')
    end

    it "has a END_REASON_UNSUBSCRIBED_ADMIN class constant set to 'UNSUBSCRIBED_ADMIN'" do
      expect(described_class::END_REASON_UNSUBSCRIBED_ADMIN).to eq('UNSUBSCRIBED_ADMIN')
    end

    it "has a END_REASON_SUSPENDED_ATTEMPTS class constant set to 'SUSPENDED_ATTEMPTS'" do
      expect(described_class::END_REASON_SUSPENDED_ATTEMPTS).to eq('SUSPENDED_ATTEMPTS')
    end

    it "has a END_REASON_SUSPENDED_EXPIRED class constant set to 'SUSPENDED_EXPIRED'" do
      expect(described_class::END_REASON_SUSPENDED_EXPIRED).to eq('SUSPENDED_EXPIRED')
    end

    it "has a END_REASON_SUSPENDED_CHARGEBACK class constant set to 'SUSPENDED_CHARGEBACK'" do
      expect(described_class::END_REASON_SUSPENDED_CHARGEBACK).to eq('SUSPENDED_CHARGEBACK')
    end

    it "has a END_REASON_COMPLETE class constant set to 'COMPLETE'" do
      expect(described_class::END_REASON_COMPLETE).to eq('COMPLETE')
    end
  end

  describe "Attributes" do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:created) }
    it { is_expected.to respond_to(:start_date) }
    it { is_expected.to respond_to(:end_date) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:phase) }
    it { is_expected.to respond_to(:end_reason) }
    it { is_expected.to respond_to(:payment_method) }
    it { is_expected.to respond_to(:website) }
    it { is_expected.to respond_to(:ems_url) }
    it { is_expected.to respond_to(:redirect_url) }
    it { is_expected.to respond_to(:plan) }
    it { is_expected.to respond_to(:customer) }
    it { is_expected.to respond_to(:plan_id) }
    it { is_expected.to respond_to(:plan_type) }
    it { is_expected.to respond_to(:extra) }
    it { is_expected.to respond_to(:reference) }
    it { is_expected.to respond_to(:redirect) }
    it { is_expected.to respond_to(:next_event) }
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      expect {
        described_class.build_from_response({ test: "test" })
      }.to_not raise_error
    end

    it "returns a Payment object" do
      expect(described_class.build_from_response({ test: "test" })).to be_a(described_class)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      expect {
        described_class.build_from_response("test")
      }.to raise_error SyspaySDK::Exceptions::BadArgumentTypeError
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
      @subscription = described_class.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      expect(@subscription.raw).to eq(response)
    end

    it "sets instance id attribute using value in response" do
      expect(@subscription.id).to eq(response[:id])
    end

    it "sets instance plan_id attribute using value in response" do
      expect(@subscription.plan_id).to eq(response[:plan_id])
    end

    it "sets instance plan_type attribute using value in response" do
      expect(@subscription.plan_type).to eq(response[:plan_type])
    end

    it "sets instance reference attribute using value in response" do
      expect(@subscription.reference).to eq(response[:reference])
    end

    it "sets instance status attribute using value in response" do
      expect(@subscription.status).to eq(response[:status])
    end

    it "sets instance phase attribute using value in response" do
      expect(@subscription.phase).to eq(response[:phase])
    end

    it "sets instance extra attribute using value in response" do
      expect(@subscription.extra).to eq(response[:extra])
    end

    it "sets instance ems_url attribute using value in response" do
      expect(@subscription.ems_url).to eq(response[:ems_url])
    end

    it "sets instance end_reason attribute using value in response" do
      expect(@subscription.end_reason).to eq(response[:end_reason])
    end

    it "sets instance created attribute using value in response" do
      created = DateTime.new(2001,2,3)
      response[:created] = created.to_time.to_i
      expect(described_class.build_from_response(response).created).to eq(created)
    end

    it "sets instance start_date attribute using value in response" do
      start_date = DateTime.new(2001,2,3)
      response[:start_date] = start_date.to_time.to_i
      expect(described_class.build_from_response(response).start_date).to eq(start_date)
    end

    it "sets instance end_date attribute using value in response" do
      end_date = DateTime.new(2001,2,3)
      response[:end_date] = end_date.to_time.to_i
      expect(described_class.build_from_response(response).end_date).to eq(end_date)
    end

    it "sets instance paymentMethod attribute using value in response" do
      response[:payment_method] = {}
      expect(described_class.build_from_response(response).payment_method).to be_a(SyspaySDK::Entities::PaymentMethod)
    end

    it "sets instance customer attribute using value in response" do
      response[:customer] = {}
      expect(described_class.build_from_response(response).customer).to be_a(SyspaySDK::Entities::Customer)
    end

    it "sets instance plan attribute using value in response" do
      response[:plan] = {}
      expect(described_class.build_from_response(response).plan).to be_a(SyspaySDK::Entities::Plan)
    end

    it "sets instance next_event attribute using value in response" do
      response[:next_event] = {}
      expect(described_class.build_from_response(response).next_event).to be_a(SyspaySDK::Entities::SubscriptionEvent)
    end
  end
end
