require 'spec_helper'

describe SyspaySDK::Requests::Payment do
  let(:subject) do
    SyspaySDK::Requests::Payment.new SyspaySDK::Requests::Payment::FLOW_API
  end

  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a FLOW_API class constant set to 'API'" do
      SyspaySDK::Requests::Payment::FLOW_API.should eq('API')
    end

    it "has a FLOW_BUYER class constant set to 'BUYER'" do
      SyspaySDK::Requests::Payment::FLOW_BUYER.should eq('BUYER')
    end

    it "has a FLOW_SELLER class constant set to 'SELLER'" do
      SyspaySDK::Requests::Payment::FLOW_SELLER.should eq('SELLER')
    end

    it "has a MODE_BOTH class constant set to 'BOTH'" do
      SyspaySDK::Requests::Payment::MODE_BOTH.should eq('BOTH')
    end

    it "has a MODE_ONLINE class constant set to 'ONLINE'" do
      SyspaySDK::Requests::Payment::MODE_ONLINE.should eq('ONLINE')
    end

    it "has a MODE_TERMINAL class constant set to 'TERMINAL'" do
      SyspaySDK::Requests::Payment::MODE_TERMINAL.should eq('TERMINAL')
    end

    it "has a METHOD_ASTROPAY_BANKTRANSFER class constant set to 'ASTROPAY_BANKTRANSFER'" do
      SyspaySDK::Requests::Payment::METHOD_ASTROPAY_BANKTRANSFER.should eq('ASTROPAY_BANKTRANSFER')
    end

    it "has a METHOD_ASTROPAY_BOLETOBANCARIO class constant set to 'ASTROPAY_BOLETOBANCARIO'" do
      SyspaySDK::Requests::Payment::METHOD_ASTROPAY_BOLETOBANCARIO.should eq('ASTROPAY_BOLETOBANCARIO')
    end

    it "has a METHOD_ASTROPAY_DEBITCARD class constant set to 'ASTROPAY_DEBITCARD'" do
      SyspaySDK::Requests::Payment::METHOD_ASTROPAY_DEBITCARD.should eq('ASTROPAY_DEBITCARD')
    end

    it "has a METHOD_CLICKANDBUY class constant set to 'CLICKANDBUY'" do
      SyspaySDK::Requests::Payment::METHOD_CLICKANDBUY.should eq('CLICKANDBUY')
    end

    it "has a METHOD_CREDITCARD class constant set to 'CREDITCARD'" do
      SyspaySDK::Requests::Payment::METHOD_CREDITCARD.should eq('CREDITCARD')
    end

    it "has a METHOD_IDEAL class constant set to 'IDEAL'" do
      SyspaySDK::Requests::Payment::METHOD_IDEAL.should eq('IDEAL')
    end

    it "has a METHOD_PAYSAFECARD class constant set to 'PAYSAFECARD'" do
      SyspaySDK::Requests::Payment::METHOD_PAYSAFECARD.should eq('PAYSAFECARD')
    end

    it "has a METHOD_POSTFINANCE class constant set to 'POSTFINANCE'" do
      SyspaySDK::Requests::Payment::METHOD_POSTFINANCE.should eq('POSTFINANCE')
    end

    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::Payment::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/payment'" do
      SyspaySDK::Requests::Payment::PATH.should eq('/api/v1/merchant/payment')
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
    it { should respond_to(:notify) }
    it { should respond_to(:bank_code) }
  end

  describe "Initialize" do
    it "can only be called with a flow parameter" do
      payment = SyspaySDK::Requests::Payment.new SyspaySDK::Requests::Payment::FLOW_API
      payment.flow.should eq(SyspaySDK::Requests::Payment::FLOW_API)
    end

    it "raises a SyspaySDK::Exception::InvalidArgumentError" do
      lambda do
        payment = SyspaySDK::Requests::Payment.new "test"
      end.should raise_error(SyspaySDK::Exceptions::InvalidArgumentError)
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::Payment::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::Payment::PATH)
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the payment" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Payment" do
      subject.build_response({ payment: {} }).should be_a(SyspaySDK::Entities::Payment)
    end

    let(:data) do
      {
        payment: {id: 137},
        redirect: "redirect"
      }
    end

    it "returns a SyspaySDK::Entities::Payment setup according to data passed in" do
      payment = subject.build_response(data)
      payment.id.should eq(data[:payment][:id])
      payment.redirect.should eq(data[:redirect])
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    describe "the returned hash" do
      it "contains the flow" do
        subject.flow = SyspaySDK::Requests::Payment::FLOW_API
        subject.get_data.should include(flow: SyspaySDK::Requests::Payment::FLOW_API)
      end

      it "contains a boolean for the billing_agreement" do
        billing_agreement = SyspaySDK::Entities::BillingAgreement.build_from_response({id: 2})
        subject.billing_agreement = billing_agreement
        subject.get_data.should include(billing_agreement: true)

        subject.billing_agreement = nil
        subject.get_data.should include(billing_agreement: false)
      end

      it "contains the mode" do
        subject.mode = SyspaySDK::Requests::Payment::MODE_BOTH
        subject.get_data.should include(mode: SyspaySDK::Requests::Payment::MODE_BOTH)
      end

      it "contains the threatmetrix_session_id" do
        subject.threatmetrix_session_id = 1
        subject.get_data.should include(threatmetrix_session_id: 1)
      end

      it "contains the payment_method" do
        subject.payment_method = "test"
        subject.get_data.should include(payment_method: "test")
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

      it "contains a hash for the payment" do
        payment = SyspaySDK::Entities::Payment.new
        payment.id = 159
        subject.payment = payment
        subject.get_data.should include(payment: payment.to_hash)
      end

      it "contains the bank_code" do
        subject.bank_code = "test"
        subject.get_data.should include(bank_code: "test")
      end

      it "contains the allowed_retries" do
        subject.allowed_retries = "test"
        subject.get_data.should include(allowed_retries: "test")
      end

      it "contains the notify" do
        subject.notify = "test"
        subject.get_data.should include(notify: "test")
      end

    end
  end
end
