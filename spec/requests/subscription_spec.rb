require 'spec_helper'

describe SyspaySDK::Requests::Subscription do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a FLOW_API class constant set to 'API'" do
      SyspaySDK::Requests::Subscription::FLOW_API.should eq('API')
    end

    it "has a FLOW_BUYER class constant set to 'BUYER'" do
      SyspaySDK::Requests::Subscription::FLOW_BUYER.should eq('BUYER')
    end

    it "has a FLOW_SELLER class constant set to 'SELLER'" do
      SyspaySDK::Requests::Subscription::FLOW_SELLER.should eq('SELLER')
    end

    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::Subscription::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/subscription'" do
      SyspaySDK::Requests::Subscription::PATH.should eq('/api/v1/merchant/subscription')
    end
  end

  describe "Attributes" do
    it { should respond_to(:flow) }
    it { should respond_to(:subscription) }
    it { should respond_to(:customer) }
    it { should respond_to(:payment_method) }
    it { should respond_to(:threatmetrix_session_id) }
    it { should respond_to(:credit_card) }
    it { should respond_to(:use_subscription) }
    it { should respond_to(:use_billing_agreement) }
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::Subscription::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::Subscription::PATH)
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the subscription" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Subscription" do
      subject.build_response({ subscription: {} }).should be_a(SyspaySDK::Entities::Subscription)
    end

    let(:data) do
      {
        subscription: {id: 137},
        redirect: "redirect"
      }
    end

    it "returns a SyspaySDK::Entities::Subscription setup according to data passed in" do
      subscription = subject.build_response(data)
      subscription.id.should eq(data[:subscription][:id])
      subscription.redirect.should eq(data[:redirect])
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    describe "the returned hash" do
      it "contains the flow" do
        subject.flow = SyspaySDK::Requests::Subscription::FLOW_API
        subject.get_data.should include(flow: SyspaySDK::Requests::Subscription::FLOW_API)
      end

      it "contains a hash for the subscription" do
        subscription = SyspaySDK::Entities::Subscription.new
        subscription.id = 159
        subject.subscription = subscription
        subject.get_data.should include(subscription: subscription.to_hash)
      end

      it "contains a hash for the customer" do
        customer = SyspaySDK::Entities::Customer.new
        customer.email = "test_email"
        subject.customer = customer
        subject.get_data.should include(customer: customer.to_hash)
      end

      it "contains the payment_method" do
        subject.payment_method = "payment_method"
        subject.get_data.should include(payment_method: "payment_method")
      end

      it "contains the threatmetrix_session_id" do
        subject.threatmetrix_session_id = 1
        subject.get_data.should include(threatmetrix_session_id: 1)
      end

      it "contains a hash for the credit_card" do
        credit_card = SyspaySDK::Entities::CreditCard.new
        credit_card.number = "1234"
        subject.credit_card = credit_card
        subject.get_data.should include(credit_card: credit_card.to_hash)
      end

      it "contains the use_subscription" do
        subject.use_subscription = true
        subject.get_data.should include(use_subscription: true)
      end

      it "contains the use_billing_agreement" do
        subject.use_billing_agreement = true
        subject.get_data.should include(use_billing_agreement: true)
      end
    end
  end
end
