require 'spec_helper'

describe SyspaySDK::Entities::Payment do
  it 'is a SyspaySDK::Entities::ReturnedEntity' do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe 'Constants' do
    it "has a TYPE class constant set to 'payment'" do
      expect(described_class::TYPE).to eq('payment')
    end

    describe 'STATUS' do
      it "has a STATUS_OPEN class constant set to 'OPEN'" do
        expect(described_class::STATUS_OPEN).to eq('OPEN')
      end
      it "has a STATUS_SUCCESS class constant set to 'SUCCESS'" do
        expect(described_class::STATUS_SUCCESS).to eq('SUCCESS')
      end
      it "has a STATUS_FAILED class constant set to 'FAILED'" do
        expect(described_class::STATUS_FAILED).to eq('FAILED')
      end
      it "has a STATUS_CANCELLED class constant set to 'CANCELLED'" do
        expect(described_class::STATUS_CANCELLED).to eq('CANCELLED')
      end
      it "has a STATUS_AUTHORIZED class constant set to 'AUTHORIZED'" do
        expect(described_class::STATUS_AUTHORIZED).to eq('AUTHORIZED')
      end
      it "has a STATUS_VOIDED class constant set to 'VOIDED'" do
        expect(described_class::STATUS_VOIDED).to eq('VOIDED')
      end
      it "has a STATUS_WAITING class constant set to 'WAITING'" do
        expect(described_class::STATUS_WAITING).to eq('WAITING')
      end
      it "has a STATUS_ERROR class constant set to 'ERROR'" do
        expect(described_class::STATUS_ERROR).to eq('ERROR')
      end
    end

    describe 'FAILURES' do
      it "has a FAILURE_CARD_FLAGGED class constant set to 'card_flagged'" do
        expect(described_class::FAILURE_CARD_FLAGGED).to eq('card_flagged')
      end

      it "has a FAILURE_DECLINED class constant set to 'declined'" do
        expect(described_class::FAILURE_DECLINED).to eq('declined')
      end

      it "has a FAILURE_DUPLICATED class constant set to 'duplicated'" do
        expect(described_class::FAILURE_DUPLICATED).to eq('duplicated')
      end

      it "has a FAILURE_EXPIRED class constant set to 'expired'" do
        expect(described_class::FAILURE_EXPIRED).to eq('expired')
      end

      it "has a FAILURE_FRAUD class constant set to 'fraud_suspicious'" do
        expect(described_class::FAILURE_FRAUD).to eq('fraud_suspicious')
      end

      it "has a FAILURE_INSUFFICIENT_FUNDS class constant set to 'insufficient_funds'" do
        expect(described_class::FAILURE_INSUFFICIENT_FUNDS).to eq('insufficient_funds')
      end

      it "has a FAILURE_INVALID_CARD class constant set to 'invalid_card'" do
        expect(described_class::FAILURE_INVALID_CARD).to eq('invalid_card')
      end

      it "has a FAILURE_INVALID_CV2 class constant set to 'invalid_cv2'" do
        expect(described_class::FAILURE_INVALID_CV2).to eq('invalid_cv2')
      end

      it "has a FAILURE_INVALID_DETAILS class constant set to 'invalid_details'" do
        expect(described_class::FAILURE_INVALID_DETAILS).to eq('invalid_details')
      end

      it "has a FAILURE_OTHER class constant set to 'other'" do
        expect(described_class::FAILURE_OTHER).to eq('other')
      end

      it "has a FAILURE_TECHNICAL_ERROR class constant set to 'technical_error'" do
        expect(described_class::FAILURE_TECHNICAL_ERROR).to eq('technical_error')
      end

      it "has a FAILURE_UNSUPPORTED class constant set to 'unsupported'" do
        expect(described_class::FAILURE_UNSUPPORTED).to eq('unsupported')
      end
    end

    describe 'TYPES' do
      it "has a TYPE_ONESHOT class constant set to 'ONESHOT'" do
        expect(described_class::TYPE_ONESHOT).to eq('ONESHOT')
      end
      it "has a TYPE_ONESHOT_RETRY class constant set to 'ONESHOT_RETRY'" do
        expect(described_class::TYPE_ONESHOT_RETRY).to eq('ONESHOT_RETRY')
      end
      it "has a TYPE_BILLING_AGREEMENT_INITIAL class constant set to 'BILLING_AGREEMENT_INITIAL'" do
        expect(described_class::TYPE_BILLING_AGREEMENT_INITIAL).to eq('BILLING_AGREEMENT_INITIAL')
      end
      it "has a TYPE_BILLING_AGREEMENT_INITIAL_RETRY class constant set to 'BILLING_AGREEMENT_INITIAL_RETRY'" do
        expect(described_class::TYPE_BILLING_AGREEMENT_INITIAL_RETRY).to eq('BILLING_AGREEMENT_INITIAL_RETRY')
      end
      it "has a TYPE_BILLING_AGREEMENT_REBILL class constant set to 'BILLING_AGREEMENT_REBILL'" do
        expect(described_class::TYPE_BILLING_AGREEMENT_REBILL).to eq('BILLING_AGREEMENT_REBILL')
      end
      it "has a TYPE_SUBSCRIPTION_TRIAL class constant set to 'SUBSCRIPTION_TRIAL'" do
        expect(described_class::TYPE_SUBSCRIPTION_TRIAL).to eq('SUBSCRIPTION_TRIAL')
      end
      it "has a TYPE_SUBSCRIPTION_INITIAL class constant set to 'SUBSCRIPTION_INITIAL'" do
        expect(described_class::TYPE_SUBSCRIPTION_INITIAL).to eq('SUBSCRIPTION_INITIAL')
      end
      it "has a TYPE_SUBSCRIPTION_BILL class constant set to 'SUBSCRIPTION_BILL'" do
        expect(described_class::TYPE_SUBSCRIPTION_BILL).to eq('SUBSCRIPTION_BILL')
      end
      it "has a TYPE_SUBSCRIPTION_MANUAL_REBILL class constant set to 'SUBSCRIPTION_MANUAL_REBILL'" do
        expect(described_class::TYPE_SUBSCRIPTION_MANUAL_REBILL).to eq('SUBSCRIPTION_MANUAL_REBILL')
      end
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:chip_and_pin_status) }
    it { is_expected.to respond_to(:failure_category) }
    it { is_expected.to respond_to(:reference) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:currency) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:extra) }
    it { is_expected.to respond_to(:preauth) }
    it { is_expected.to respond_to(:website) }
    it { is_expected.to respond_to(:billing_agreement) }
    it { is_expected.to respond_to(:subscription) }
    it { is_expected.to respond_to(:redirect) }
    it { is_expected.to respond_to(:processing_time) }
    it { is_expected.to respond_to(:recipient_map) }
    it { is_expected.to respond_to(:payment_type) }
    it { is_expected.to respond_to(:website_url) }
    it { is_expected.to respond_to(:contract) }
    it { is_expected.to respond_to(:descriptor) }
    it { is_expected.to respond_to(:account_id) }
    it { is_expected.to respond_to(:merchant_login) }
    it { is_expected.to respond_to(:merchant_id) }
    it { is_expected.to respond_to(:settlement_date) }
    it { is_expected.to respond_to(:payment_method) }
  end

  describe '::build_from_response' do
    it "doesn't raise an error when called" do
      expect do
        described_class.build_from_response(test: 'test')
      end.to_not raise_error
    end

    it 'returns a Payment object' do
      expect(described_class.build_from_response(test: 'test')).to be_a(described_class)
    end

    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        described_class.build_from_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let(:response) do
      {
        id: 'id',
        reference: 'reference',
        amount: 'amount',
        currency: 'currency',
        status: 'status',
        extra: 'extra',
        description: 'description',
        website: 'website',
        failure_category: 'failure_category',
        chip_and_pin_status: 'chip_and_pin_status',
        payment_type: 'payment_type',
        website_url: 'website_url',
        contract: 'contract',
        descriptor: 'descriptor',
        account_id: 'account_id',
        merchant_login: 'merchant_login',
        merchant_id: 'merchant_id'
      }
    end

    before(:each) do
      @payment = described_class.build_from_response(response)
    end

    it 'sets instance raw attribute to response' do
      expect(@payment.raw).to eq(response)
    end

    it 'sets instance id attribute using value in response' do
      expect(@payment.id).to eq(response[:id])
    end

    it 'sets instance reference attribute using value in response' do
      expect(@payment.reference).to eq(response[:reference])
    end

    it 'sets instance amount attribute using value in response' do
      expect(@payment.amount).to eq(response[:amount])
    end

    it 'sets instance currency attribute using value in response' do
      expect(@payment.currency).to eq(response[:currency])
    end

    it 'sets instance status attribute using value in response' do
      expect(@payment.status).to eq(response[:status])
    end

    it 'sets instance extra attribute using value in response' do
      expect(@payment.extra).to eq(response[:extra])
    end

    it 'sets instance description attribute using value in response' do
      expect(@payment.description).to eq(response[:description])
    end

    it 'sets instance website attribute using value in response' do
      expect(@payment.website).to eq(response[:website])
    end

    it 'sets instance failure_category attribute using value in response' do
      expect(@payment.failure_category).to eq(response[:failure_category])
    end

    it 'sets instance chip_and_pin_status attribute using value in response' do
      expect(@payment.chip_and_pin_status).to eq(response[:chip_and_pin_status])
    end

    it 'sets instance payment_type attribute using value in response' do
      expect(@payment.payment_type).to eq(response[:payment_type])
    end

    it 'sets instance website_url attribute using value in response' do
      expect(@payment.website_url).to eq(response[:website_url])
    end

    it 'sets instance contract attribute using value in response' do
      expect(@payment.contract).to eq(response[:contract])
    end

    it 'sets instance descriptor attribute using value in response' do
      expect(@payment.descriptor).to eq(response[:descriptor])
    end

    it 'sets instance account_id attribute using value in response' do
      expect(@payment.account_id).to eq(response[:account_id])
    end

    it 'sets instance merchant_login attribute using value in response' do
      expect(@payment.merchant_login).to eq(response[:merchant_login])
    end

    it 'sets instance merchant_id attribute using value in response' do
      expect(@payment.merchant_id).to eq(response[:merchant_id])
    end

    it 'sets instance settlement_date attribute using value in response' do
      settlement_date = Time.now
      response[:settlement_date] = settlement_date.to_i
      expect(described_class.build_from_response(response).settlement_date).to be_a(Time)
      expect(described_class.build_from_response(response).settlement_date).to eq(Time.at(settlement_date.to_i))
    end

    it 'sets instance processing_time attribute using value in response' do
      processing_time = Time.now
      response[:processing_time] = processing_time.to_i
      expect(described_class.build_from_response(response).processing_time).to be_a(Time)
      expect(described_class.build_from_response(response).processing_time).to eq(Time.at(processing_time.to_i))
    end

    it 'sets instance subscription attribute using value in response' do
      response[:subscription] = {}
      expect(described_class.build_from_response(response).subscription).to be_a(SyspaySDK::Entities::Subscription)
    end

    it 'sets instance payment_method attribute using value in response' do
      response[:payment_method] = {}
      expect(described_class.build_from_response(response).payment_method).to be_a(SyspaySDK::Entities::PaymentMethod)
    end

    it 'sets instance billing_agreement attribute using value in response' do
      response[:billing_agreement] = {}
      expect(described_class.build_from_response(response).billing_agreement).to be_a(SyspaySDK::Entities::BillingAgreement)
    end
  end

  describe '#assign_recipient_map' do
    it 'sets the instance recipient_map attribute properly' do
      recipient_map = [SyspaySDK::Entities::PaymentRecipient.new, SyspaySDK::Entities::PaymentRecipient.new]
      subject.assign_recipient_map(recipient_map)

      expect(subject.recipient_map).to eq(recipient_map)
    end

    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when recipient_map doesn't contain only PaymentRecipient" do
      recipient_map = [SyspaySDK::Entities::PaymentRecipient.new, described_class.new]

      expect do
        subject.assign_recipient_map(recipient_map)
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end
  end

  it 'responds to #add_recipient' do
    expect(subject).to respond_to(:add_recipient)
  end

  describe '#add_recipient' do
    it 'adds a recipient to the instance recipient_map array' do
      recipient = SyspaySDK::Entities::PaymentRecipient.new
      subject.add_recipient recipient
      expect(subject.recipient_map).to include(recipient)
    end

    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when recipient is not a PaymentRecipient' do
      recipient = 'Not a PaymentRecipient'

      expect do
        subject.add_recipient recipient
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end
  end

  describe '#to_hash' do
    let(:response) do
      {
        id: 'id',
        reference: 'reference',
        amount: 'amount',
        currency: 'currency',
        status: 'status',
        extra: 'extra',
        description: 'description',
        website: 'website',
        failure_category: 'failure_category',
        chip_and_pin_status: 'chip_and_pin_status',
        payment_type: 'payment_type',
        website_url: 'website_url',
        contract: 'contract',
        descriptor: 'descriptor',
        account_id: 'account_id',
        merchant_login: 'merchant_login',
        merchant_id: 'merchant_id'
      }
    end

    let(:subject) do
      described_class.build_from_response(response)
    end

    it 'returns the payment converted to a hash' do
      hash = subject.to_hash

      expect(hash).to include(reference: response[:reference])
      expect(hash).to include(amount: response[:amount])
      expect(hash).to include(currency: response[:currency])
      expect(hash).to include(description: response[:description])
      expect(hash).to include(extra: response[:extra])
      expect(hash).to include(preauth: response[:preauth])

      expect(hash[:recipients]).to eq([])
    end

    it 'should include the recipients with one hash per recipient' do
      recipient1 = SyspaySDK::Entities::PaymentRecipient.new
      recipient2 = SyspaySDK::Entities::PaymentRecipient.new
      recipients_map = [recipient1, recipient2]

      subject.assign_recipient_map recipients_map

      hash = subject.to_hash

      expect(hash[:recipients]).to include(recipient1.to_hash)
      expect(hash[:recipients]).to include(recipient2.to_hash)
    end
  end
end
