require 'spec_helper'

describe SyspaySDK::Requests::Rebill do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::Rebill::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/billing-agreement/:billing_agreement_id/rebill'" do
      SyspaySDK::Requests::Rebill::PATH.should eq('/api/v1/merchant/billing-agreement/:billing_agreement_id/rebill')
    end
  end

  describe "Attributes" do
    it { should respond_to(:threatmetrix_session_id) }
    it { should respond_to(:ems_url) }
    it { should respond_to(:billing_agreement_id) }
    it { should respond_to(:reference) }
    it { should respond_to(:amount) }
    it { should respond_to(:currency) }
    it { should respond_to(:description) }
    it { should respond_to(:extra) }
    it { should respond_to(:recipient_map) }
  end

  describe "Initialize" do
    it "can be initialized with a billing_agreement_id parameter" do
      rebill = SyspaySDK::Requests::Rebill.new "id"
      rebill.billing_agreement_id.should eq("id")
    end

    it "can be initialized without arguments" do
      rebill = SyspaySDK::Requests::Rebill.new
      rebill.billing_agreement_id.should be_nil
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::Rebill::PATH)
    end
    it "returns the PATH constant with billing_agreement_id if exists" do
      with_billing_agreement_id = SyspaySDK::Requests::Rebill.new "test_billing_agreement_id"
      with_billing_agreement_id.get_path.should eq(SyspaySDK::Requests::Rebill::PATH.gsub(/:billing_agreement_id/, "test_billing_agreement_id"))
    end
  end

  it "responds to #set_recipient_map" do
    subject.should respond_to(:set_recipient_map)
  end

  describe "#set_recipient_map" do
    it "sets the instance recipient_map attribute properly" do
      recipient_map = [SyspaySDK::Entities::PaymentRecipient.new, SyspaySDK::Entities::PaymentRecipient.new]
      subject.set_recipient_map(recipient_map)

      subject.recipient_map.should eq(recipient_map)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when recipient_map doesn't contain only PaymentRecipient" do
      recipient_map = [SyspaySDK::Entities::PaymentRecipient.new, SyspaySDK::Entities::Payment.new]

      lambda do
        subject.set_recipient_map(recipient_map)
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end
  end

  it "responds to #add_recipient" do
    subject.should respond_to(:add_recipient)
  end

  describe "#add_recipient" do
    it "adds a recipient to the instance recipient_map array" do
      recipient = SyspaySDK::Entities::PaymentRecipient.new
      subject.add_recipient recipient
      subject.recipient_map.should include(recipient)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when recipient is not a PaymentRecipient" do
      recipient = "Not a PaymentRecipient"

      lambda do
        subject.add_recipient recipient
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
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
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash" do
      subject.get_data.should be_a(Hash)
    end

    describe "the returned hash" do
      it "contains the threatmetrix_session_id" do
        subject.threatmetrix_session_id = "threatmetrix_session_id"
        subject.get_data.should include(threatmetrix_session_id: "threatmetrix_session_id")
      end

      it "contains the ems_url" do
        subject.ems_url = "ems_url"
        subject.get_data.should include(ems_url: "ems_url")
      end

      describe "contains the payment hash which" do
        it "is always present" do
          subject.get_data.keys.should include(:payment)
        end

        it "contains the reference" do
          subject.reference = "reference"
          subject.get_data[:payment].should include(reference: "reference")
        end

        it "contains the amount" do
          subject.amount = "amount"
          subject.get_data[:payment].should include(amount: "amount")
        end

        it "contains the currency" do
          subject.currency = "currency"
          subject.get_data[:payment].should include(currency: "currency")
        end

        it "contains the description" do
          subject.description = "description"
          subject.get_data[:payment].should include(description: "description")
        end

        it "contains the extra" do
          subject.extra = "extra"
          subject.get_data[:payment].should include(extra: "extra")
        end

        it "contains the recipient_map" do
          recipient1 = SyspaySDK::Entities::PaymentRecipient.new
          recipient2 = SyspaySDK::Entities::PaymentRecipient.new
          subject.set_recipient_map [recipient1, recipient2]
          subject.get_data[:payment].should include(recipient_map: [recipient1.to_hash, recipient2.to_hash])
        end
      end
    end
  end
end
