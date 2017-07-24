require 'spec_helper'

describe SyspaySDK::Requests::BillingAgreement do
  let(:subject) do
    SyspaySDK::Requests::BillingAgreement.new SyspaySDK::Requests::BillingAgreement::FLOW_API
  end

  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a FLOW_API class constant set to 'API'" do
      SyspaySDK::Requests::BillingAgreement::FLOW_API.should eq('API')
    end

    it "has a FLOW_BUYER class constant set to 'BUYER'" do
      SyspaySDK::Requests::BillingAgreement::FLOW_BUYER.should eq('BUYER')
    end

    it "has a FLOW_SELLER class constant set to 'SELLER'" do
      SyspaySDK::Requests::BillingAgreement::FLOW_SELLER.should eq('SELLER')
    end

    it "has a MODE_BOTH class constant set to 'BOTH'" do
      SyspaySDK::Requests::BillingAgreement::MODE_BOTH.should eq('BOTH')
    end

    it "has a MODE_ONLINE class constant set to 'ONLINE'" do
      SyspaySDK::Requests::BillingAgreement::MODE_ONLINE.should eq('ONLINE')
    end

    it "has a MODE_TERMINAL class constant set to 'TERMINAL'" do
      SyspaySDK::Requests::BillingAgreement::MODE_TERMINAL.should eq('TERMINAL')
    end

    it "has a METHOD_ASTROPAY_BANKTRANSFER class constant set to 'ASTROPAY_BANKTRANSFER'" do
      SyspaySDK::Requests::BillingAgreement::METHOD_ASTROPAY_BANKTRANSFER.should eq('ASTROPAY_BANKTRANSFER')
    end

    it "has a METHOD_ASTROPAY_BOLETOBANCARIO class constant set to 'ASTROPAY_BOLETOBANCARIO'" do
      SyspaySDK::Requests::BillingAgreement::METHOD_ASTROPAY_BOLETOBANCARIO.should eq('ASTROPAY_BOLETOBANCARIO')
    end

    it "has a METHOD_ASTROPAY_DEBITCARD class constant set to 'ASTROPAY_DEBITCARD'" do
      SyspaySDK::Requests::BillingAgreement::METHOD_ASTROPAY_DEBITCARD.should eq('ASTROPAY_DEBITCARD')
    end

    it "has a METHOD_CLICKANDBUY class constant set to 'CLICKANDBUY'" do
      SyspaySDK::Requests::BillingAgreement::METHOD_CLICKANDBUY.should eq('CLICKANDBUY')
    end

    it "has a METHOD_CREDITCARD class constant set to 'CREDITCARD'" do
      SyspaySDK::Requests::BillingAgreement::METHOD_CREDITCARD.should eq('CREDITCARD')
    end

    it "has a METHOD_IDEAL class constant set to 'IDEAL'" do
      SyspaySDK::Requests::BillingAgreement::METHOD_IDEAL.should eq('IDEAL')
    end

    it "has a METHOD_PAYSAFECARD class constant set to 'PAYSAFECARD'" do
      SyspaySDK::Requests::BillingAgreement::METHOD_PAYSAFECARD.should eq('PAYSAFECARD')
    end

    it "has a METHOD_POSTFINANCE class constant set to 'POSTFINANCE'" do
      SyspaySDK::Requests::BillingAgreement::METHOD_POSTFINANCE.should eq('POSTFINANCE')
    end

    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::BillingAgreement::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/billing-agreement'" do
      SyspaySDK::Requests::BillingAgreement::PATH.should eq('/api/v1/merchant/billing-agreement')
    end
  end

  describe "Attributes" do
    it { should respond_to(:flow) }
    it { should respond_to(:mode) }
    it { should respond_to(:payment_method) }
    it { should respond_to(:threatmetrix_session_id) }
    it { should respond_to(:billing_agreement) }
    it { should respond_to(:ems_url) }
    it { should respond_to(:redirect_url) }
    it { should respond_to(:website) }
    it { should respond_to(:agent) }
    it { should respond_to(:allowed_retries) }
    it { should respond_to(:payment) }
    it { should respond_to(:customer) }
    it { should respond_to(:credit_card) }
    it { should respond_to(:bank_code) }
    it { should respond_to(:reference) }
    it { should respond_to(:currency) }
    it { should respond_to(:description) }
    it { should respond_to(:extra) }
  end

  describe "Initialize" do
    it "can only be called with a flow parameter" do
      billing_agreement = SyspaySDK::Requests::BillingAgreement.new SyspaySDK::Requests::BillingAgreement::FLOW_API
      billing_agreement.flow.should eq(SyspaySDK::Requests::BillingAgreement::FLOW_API)
    end

    it "raises a SyspaySDK::Exception::InvalidArgumentError" do
      lambda do
        billing_agreement = SyspaySDK::Requests::BillingAgreement.new "test"
      end.should raise_error(SyspaySDK::Exceptions::InvalidArgumentError)
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::BillingAgreement::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::BillingAgreement::PATH)
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the billing_agreement" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::BillingAgreement" do
      subject.build_response({ billing_agreement: {} }).should be_a(SyspaySDK::Entities::BillingAgreement)
    end

    let(:data) do
      {
        billing_agreement: {id: 137},
        redirect: "redirect"
      }
    end

    it "returns a SyspaySDK::Entities::BillingAgreement setup according to data passed in" do
      billing_agreement = subject.build_response(data)
      billing_agreement.id.should eq(data[:billing_agreement][:id])
      billing_agreement.redirect.should eq(data[:redirect])
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    describe "the returned hash" do
      it "contains the flow" do
        subject.flow = SyspaySDK::Requests::BillingAgreement::FLOW_API
        subject.get_data.should include(flow: SyspaySDK::Requests::BillingAgreement::FLOW_API)
      end

      it "contains a boolean for the billing_agreement" do
        billing_agreement = SyspaySDK::Entities::BillingAgreement.build_from_response({id: 2})
        subject.billing_agreement = billing_agreement
        subject.get_data.should include(billing_agreement: true)

        subject.billing_agreement = nil
        subject.get_data.should include(billing_agreement: false)
      end

      it "contains the mode" do
        subject.mode = SyspaySDK::Requests::BillingAgreement::MODE_BOTH
        subject.get_data.should include(mode: SyspaySDK::Requests::BillingAgreement::MODE_BOTH)
      end

      it "contains the threatmetrix_session_id" do
        subject.threatmetrix_session_id = 1
        subject.get_data.should include(threatmetrix_session_id: 1)
      end

      it "contains the method" do
        subject.payment_method = "test"
        subject.get_data.should include(method: "test")
      end

      it "contains the website" do
        subject.website = "test"
        subject.get_data.should include(website: "test")
      end

      it "contains the agent" do
        subject.agent = "test"
        subject.get_data.should include(agent: "test")
      end

      it "contains the redirect_url" do
        subject.redirect_url = "test"
        subject.get_data.should include(redirect_url: "test")
      end

      it "contains the ems_url" do
        subject.ems_url = "test"
        subject.get_data.should include(ems_url: "test")
      end

      it "contains a hash for the credit_card" do
        credit_card = SyspaySDK::Entities::CreditCard.new
        credit_card.number = 159
        subject.credit_card = credit_card
        subject.get_data.should include(credit_card: credit_card.to_hash)
      end

      it "contains a hash for the customer" do
        customer = SyspaySDK::Entities::Customer.new
        customer.email = "test"
        subject.customer = customer
        subject.get_data.should include(customer: customer.to_hash)
      end

      it "contains the bank_code" do
        subject.bank_code = "test"
        subject.get_data.should include(bank_code: "test")
      end

      it "contains the reference" do
        subject.reference = "test"
        subject.get_data.should include(reference: "test")
      end

      it "contains the currency" do
        subject.currency = "test"
        subject.get_data.should include(currency: "test")
      end

      it "contains the description" do
        subject.description = "test"
        subject.get_data.should include(description: "test")
      end

      it "contains the allowed_retries" do
        subject.allowed_retries = "test"
        subject.get_data.should include(allowed_retries: "test")
      end

      it "contains the extra" do
        subject.extra = "test"
        subject.get_data.should include(extra: "test")
      end

    end
  end
end


