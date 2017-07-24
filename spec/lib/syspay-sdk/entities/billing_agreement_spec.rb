require 'spec_helper'

describe SyspaySDK::Entities::BillingAgreement do
  it "is a SyspaySDK::Entities::ReturnedEntity" do
    subject.should be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe "Constants" do
    it "has a TYPE class constant set to 'billing_agreement'" do
      SyspaySDK::Entities::BillingAgreement::TYPE.should eq('billing_agreement')
    end

    it "has a STATUS_PENDING class constant set to 'PENDING'" do
      SyspaySDK::Entities::BillingAgreement::STATUS_PENDING.should eq('PENDING')
    end
    it "has a STATUS_ACTIVE class constant set to 'ACTIVE'" do
      SyspaySDK::Entities::BillingAgreement::STATUS_ACTIVE.should eq('ACTIVE')
    end
    it "has a STATUS_CANCELLED class constant set to 'CANCELLED'" do
      SyspaySDK::Entities::BillingAgreement::STATUS_CANCELLED.should eq('CANCELLED')
    end
    it "has a STATUS_ENDED class constant set to 'ENDED'" do
      SyspaySDK::Entities::BillingAgreement::STATUS_ENDED.should eq('ENDED')
    end
    it "has a END_REASON_UNSUBSCRIBED_MERCHANT class constant set to 'UNSUBSCRIBED_MERCHANT'" do
      SyspaySDK::Entities::BillingAgreement::END_REASON_UNSUBSCRIBED_MERCHANT.should eq('UNSUBSCRIBED_MERCHANT')
    end
    it "has a END_REASON_UNSUBSCRIBED_ADMIN class constant set to 'UNSUBSCRIBED_ADMIN'" do
      SyspaySDK::Entities::BillingAgreement::END_REASON_UNSUBSCRIBED_ADMIN.should eq('UNSUBSCRIBED_ADMIN')
    end
    it "has a END_REASON_SUSPENDED_EXPIRED class constant set to 'SUSPENDED_EXPIRED'" do
      SyspaySDK::Entities::BillingAgreement::END_REASON_SUSPENDED_EXPIRED.should eq('SUSPENDED_EXPIRED')
    end
    it "has a END_REASON_SUSPENDED_CHARGEBACK class constant set to 'SUSPENDED_CHARGEBACK'" do
      SyspaySDK::Entities::BillingAgreement::END_REASON_SUSPENDED_CHARGEBACK.should eq('SUSPENDED_CHARGEBACK')
    end
  end

  describe "Attributes" do
    it { should respond_to(:id) }
    it { should respond_to(:status) }
    it { should respond_to(:currency) }
    it { should respond_to(:extra) }
    it { should respond_to(:end_reason) }
    it { should respond_to(:payment_method) }
    it { should respond_to(:customer) }
    it { should respond_to(:expiration_date) }
    it { should respond_to(:redirect) }
    it { should respond_to(:description) }
  end

  it "responds to ::build_from_response" do
    SyspaySDK::Entities::BillingAgreement.should respond_to(:build_from_response)
  end

  describe "::build_from_response" do
    it "doesn't raise an error when called" do
      lambda do
        SyspaySDK::Entities::BillingAgreement.build_from_response({ test: "test" })
      end.should_not raise_error
    end

    it "returns a BillingAgreement object" do
      SyspaySDK::Entities::BillingAgreement.build_from_response({ test: "test" }).should be_a(SyspaySDK::Entities::BillingAgreement)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        SyspaySDK::Entities::BillingAgreement.build_from_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let (:response) do
      {
        id: "id",
        status: "status",
        currency: "currency",
        extra: "extra",
        end_reason: "end_reason"
      }
    end

    before(:each) do
      @billing_agreement = SyspaySDK::Entities::BillingAgreement.build_from_response(response)
    end

    it "sets instance raw attribute to response" do
      @billing_agreement.raw.should eq(response)
    end

    it "sets instance id attribute using value in response" do
      @billing_agreement.id.should eq(response[:id])
    end

    it "sets instance status attribute using value in response" do
      @billing_agreement.status.should eq(response[:status])
    end

    it "sets instance currency attribute using value in response" do
      @billing_agreement.currency.should eq(response[:currency])
    end

    it "sets instance extra attribute using value in response" do
      @billing_agreement.extra.should eq(response[:extra])
    end

    it "sets instance end_reason attribute using value in response" do
      @billing_agreement.end_reason.should eq(response[:end_reason])
    end

    it "sets instance expiration_date attribute using value in response" do
      expiration_date = DateTime.new(2001,2,3)
      response[:expiration_date] = expiration_date.to_time.to_i
      SyspaySDK::Entities::BillingAgreement.build_from_response(response).expiration_date.should eq(expiration_date)
    end

    it "sets instance payment_method attribute using value in response" do
      response[:payment_method] = {}
      SyspaySDK::Entities::BillingAgreement.build_from_response(response).payment_method.should be_a(SyspaySDK::Entities::PaymentMethod)
    end

    it "sets instance customer attribute using value in response" do
      response[:customer] = {}
      SyspaySDK::Entities::BillingAgreement.build_from_response(response).customer.should be_a(SyspaySDK::Entities::Customer)
    end
  end
end
