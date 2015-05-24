require 'spec_helper'

describe SyspaySDK::Requests::Eterminal do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::Eterminal::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to ' '/api/v1/merchant/eterminal'" do
      SyspaySDK::Requests::Eterminal::PATH.should eq('/api/v1/merchant/eterminal')
    end

    it "has a TYPE_ONESHOT class constant set to 'ONESHOT'" do
      SyspaySDK::Requests::Eterminal::TYPE_ONESHOT.should eq('ONESHOT')
    end

    it "has a TYPE_SUBSCRIPTION class constant set to 'SUBSCRIPTION'" do
      SyspaySDK::Requests::Eterminal::TYPE_SUBSCRIPTION.should eq('SUBSCRIPTION')
    end

    it "has a TYPE_PAYMENT_PLAN class constant set to 'PAYMENT_PLAN'" do
      SyspaySDK::Requests::Eterminal::TYPE_PAYMENT_PLAN.should eq('PAYMENT_PLAN')
    end

    it "has a TYPE_PAYMENT_MANDATE class constant set to 'PAYMENT_MANDATE'" do
      SyspaySDK::Requests::Eterminal::TYPE_PAYMENT_MANDATE.should eq('PAYMENT_MANDATE')
    end
  end

  describe "Attributes" do
    it { should respond_to(:website) }
    it { should respond_to(:locked) }
    it { should respond_to(:ems_url) }
    it { should respond_to(:payment_redirect_url) }
    it { should respond_to(:eterminal_redirect_url) }
    it { should respond_to(:type) }
    it { should respond_to(:description) }
    it { should respond_to(:reference) }
    it { should respond_to(:customer) }
    it { should respond_to(:oneshot) }
    it { should respond_to(:subscription) }
    it { should respond_to(:payment_plan) }
    it { should respond_to(:payment_mandate) }
    it { should respond_to(:allowed_retries) }
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::Eterminal::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::Eterminal::PATH)
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the eterminal" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Eterminal" do
      subject.build_response({ eterminal: {} }).should be_a(SyspaySDK::Entities::Eterminal)
    end

    let(:data) do
      {
        eterminal: {url: "test_url"}
      }
    end

    it "returns a SyspaySDK::Entities::Eterminal setup according to data passed in" do
      eterminal = subject.build_response(data)
      eterminal.url.should eq(data[:eterminal][:url])
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    describe "the returned hash" do
      it "contains a boolean for locked" do
        subject.locked = true
        subject.get_data.should include(locked: true)

        subject.locked = nil
        subject.get_data.should include(locked: false)
      end

      it "contains the type" do
        subject.type = SyspaySDK::Requests::Eterminal::TYPE_ONESHOT
        subject.get_data.should include(type: SyspaySDK::Requests::Eterminal::TYPE_ONESHOT)
      end

      it "contains the website" do
        subject.website = "website"
        subject.get_data.should include(website: "website")
      end

      it "contains the ems_url" do
        subject.ems_url = "ems_url"
        subject.get_data.should include(ems_url: "ems_url")
      end

      it "contains the payment_redirect_url" do
        subject.payment_redirect_url = "payment_redirect_url"
        subject.get_data.should include(payment_redirect_url: "payment_redirect_url")
      end

      it "contains the eterminal_redirect_url" do
        subject.eterminal_redirect_url = "eterminal_redirect_url"
        subject.get_data.should include(eterminal_redirect_url: "eterminal_redirect_url")
      end

      it "contains the description" do
        subject.description = "description"
        subject.get_data.should include(description: "description")
      end

      it "contains the reference" do
        subject.reference = "reference"
        subject.get_data.should include(reference: "reference")
      end

      it "contains the customer" do
        subject.customer = "customer"
        subject.get_data.should include(customer: "customer")
      end

      it "contains the oneshot" do
        subject.oneshot = "oneshot"
        subject.get_data.should include(oneshot: "oneshot")
      end

      it "contains the subscription" do
        subject.subscription = "subscription"
        subject.get_data.should include(subscription: "subscription")
      end

      it "contains the payment_plan" do
        subject.payment_plan = "payment_plan"
        subject.get_data.should include(payment_plan: "payment_plan")
      end

      it "contains the payment_mandate" do
        subject.payment_mandate = "payment_mandate"
        subject.get_data.should include(payment_mandate: "payment_mandate")
      end

      it "contains the allowed_retries" do
        subject.allowed_retries = "allowed_retries"
        subject.get_data.should include(allowed_retries: "allowed_retries")
      end
    end
  end
end