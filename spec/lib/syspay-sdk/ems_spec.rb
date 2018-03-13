describe SyspaySDK::EMS do
  let(:id) { 123 }
  let(:merchant) { SyspaySDK::Config.config.syspay_id }
  let(:passphrase) { SyspaySDK::Config.config.syspay_passphrase }
  let(:checksum) { 'checksum' }
  let(:type) { 'payment' }
  let(:date) { Time.now.to_i }
  let(:data) { double(:data) }
  let(:skip_checksum) { false }

  subject do
    described_class.new(
      data: data,
      checksum: checksum,
      merchant: merchant,
      type: type,
      id: id,
      date: date,
      skip_checksum: skip_checksum
    )
  end

  it { is_expected.to respond_to(:id) }
  it { is_expected.to respond_to(:date) }
  it { is_expected.to respond_to(:type) }

  describe 'Constants' do
    describe 'Error codes' do
      it 'defines a CODE_MISSING_HEADER error code' do
        expect(described_class::CODE_INVALID_MERCHANT).to eq(0)
      end
      it 'defines a CODE_INVALID_CHECKSUM error code' do
        expect(described_class::CODE_INVALID_CHECKSUM).to eq(1)
      end
      it 'defines a CODE_INVALID_CONTENT error code' do
        expect(described_class::CODE_INVALID_CONTENT).to eq(2)
      end
    end

    describe 'Header names' do
      it 'defines a EVENT_ID_HEADER' do
        expect(described_class::EVENT_ID_HEADER).to eq('X-Event-Id')
      end
      it 'defines a EVENT_DATE_HEADER' do
        expect(described_class::EVENT_DATE_HEADER).to eq('X-Event-Date')
      end
      it 'defines a CHECKSUM_HEADER' do
        expect(described_class::CHECKSUM_HEADER).to eq('X-Checksum')
      end
      it 'defines a MERCHANT_HEADER' do
        expect(described_class::MERCHANT_HEADER).to eq('X-Merchant')
      end
    end
  end

  describe 'initilization' do
    it 'properly assigns the params' do
      expect(subject).to be_a(described_class)
      expect(subject.instance_variable_get(:@data)).to eq(data)
      expect(subject.instance_variable_get(:@checksum)).to eq(checksum)
      expect(subject.instance_variable_get(:@merchant)).to eq(merchant)
      expect(subject.instance_variable_get(:@passphrase)).to eq(passphrase)
      expect(subject.instance_variable_get(:@id)).to eq(id)
      expect(subject.instance_variable_get(:@date)).to eq(Time.at(date))
      expect(subject.instance_variable_get(:@skip_checksum)).to eq(false)
    end

    it 'accepts an optional skip_checksum argument' do
      ems = described_class.new(
        data: data,
        checksum: checksum,
        merchant: merchant,
        type: type,
        id: id,
        date: date,
        skip_checksum: true
      )

      expect(ems.instance_variable_get(:@skip_checksum)).to eq(true)
    end

    context 'When the merchant parameter does not match the one in config' do
      let(:merchant) { '123456' }

      it 'raises an EMSError with code CODE_UNKNOWN_MERCHANT' do
        expect do
          described_class.new(
            data: data,
            checksum: checksum,
            merchant: merchant,
            type: type,
            id: id,
            date: date,
            skip_checksum: true
          )
        end.to raise_error(SyspaySDK::Exceptions::EMSError, "Invalid merchant. Error code : #{SyspaySDK::EMS::CODE_INVALID_MERCHANT}")
      end
    end

    context 'When the checksum parameter is nil' do
      let(:checksum) { nil }

      it 'raises an EMSError with code CODE_UNKNOWN_MERCHANT' do
        expect do
          described_class.new(
            data: data,
            checksum: checksum,
            merchant: merchant,
            type: type,
            id: id,
            date: date,
            skip_checksum: true
          )
        end.to raise_error(SyspaySDK::Exceptions::EMSError, "Invalid checksum. Error code : #{SyspaySDK::EMS::CODE_INVALID_CHECKSUM}")
      end
    end
  end

  describe '.verify!' do
    context 'When the utility returns false' do
      before do
        expect(SyspaySDK::Checksum).to receive(:check).with(data, passphrase, checksum).and_return(false)
      end

      it 'raises an error' do
        expect do
          subject.verify!
        end.to raise_error(SyspaySDK::Exceptions::EMSError, "Invalid checksum. Error code : #{SyspaySDK::EMS::CODE_INVALID_CHECKSUM}")
      end
    end
  end

  describe '.entity' do
    let(:payment) { double(:payment) }
    let(:type) { 'payment' }

    context 'When skip_checksum is true' do
      let(:skip_checksum) { true }

      it 'does not invoke verify!' do
        allow(SyspaySDK::Entities::Payment).to receive(:build_from_response).with(payment).and_return(payment)
        allow(data).to receive(:[]).with(:payment).and_return(payment)
        expect(subject).not_to receive(:verify!)

        subject.entity
      end
    end

    context 'When skip_checksum is false' do
      before do
        allow(SyspaySDK::Checksum).to receive(:check).with(data, passphrase, checksum).and_return(true)
      end

      it 'invokes verify!' do
        allow(SyspaySDK::Entities::Payment).to receive(:build_from_response).with(payment).and_return(payment)
        allow(data).to receive(:[]).with(:payment).and_return(payment)
        expect(subject).to receive(:verify!)

        subject.entity
      end

      context 'When type is blank' do
        let(:type) { nil }

        it 'raises an error' do
          expect do
            subject.entity
          end.to raise_error(SyspaySDK::Exceptions::EMSError, "Unable to get event type. Error code : #{SyspaySDK::EMS::CODE_INVALID_CONTENT}")
        end
      end

      context 'When data is blank' do
        let(:data) { nil }

        it 'raises an error' do
          expect do
            subject.entity
          end.to raise_error(SyspaySDK::Exceptions::EMSError, "Unable to get data from content. Error code : #{SyspaySDK::EMS::CODE_INVALID_CONTENT}")
        end
      end

      context 'When type is payment' do
        context 'When the payment object is available in data' do
          before do
            allow(data).to receive(:[]).with(:payment).and_return(payment)
          end

          it 'calls SyspaySDK::Entities::Payment.build_from_response' do
            expect(SyspaySDK::Entities::Payment).to receive(:build_from_response).with(payment).and_return(payment)

            expect(subject.entity).to eq(payment)
          end
        end

        context 'When the payment object is not available in data' do
          before do
            allow(data).to receive(:[]).with(:payment).and_return(nil)
          end

          it 'raise an error' do
            expect do
              subject.entity
            end.to raise_error(SyspaySDK::Exceptions::EMSError, "Payment event received with no payment data. Error code : #{SyspaySDK::EMS::CODE_INVALID_CONTENT}")
          end
        end
      end

      context 'When type is refund' do
        let(:refund) { double(:refund) }
        let(:type) { 'refund' }

        context 'When the refund object is available in data' do
          before do
            allow(data).to receive(:[]).with(:refund).and_return(refund)
          end

          it 'calls SyspaySDK::Entities::Refund.build_from_response' do
            expect(SyspaySDK::Entities::Refund).to receive(:build_from_response).with(refund).and_return(refund)

            expect(subject.entity).to eq(refund)
          end
        end

        context 'When the refund object is not available in data' do
          before do
            allow(data).to receive(:[]).with(:refund).and_return(nil)
          end

          it 'raise an error' do
            expect do
              subject.entity
            end.to raise_error(SyspaySDK::Exceptions::EMSError, "Refund event received with no refund data. Error code : #{SyspaySDK::EMS::CODE_INVALID_CONTENT}")
          end
        end
      end

      context 'When type is chargeback' do
        let(:chargeback) { double(:chargeback) }
        let(:type) { 'chargeback' }

        context 'When the chargeback object is available in data' do
          before do
            allow(data).to receive(:[]).with(:chargeback).and_return(chargeback)
          end

          it 'calls SyspaySDK::Entities::Chargeback.build_from_response' do
            expect(SyspaySDK::Entities::Chargeback).to receive(:build_from_response).with(chargeback).and_return(chargeback)

            expect(subject.entity).to eq(chargeback)
          end
        end

        context 'When the chargeback object is not available in data' do
          before do
            allow(data).to receive(:[]).with(:chargeback).and_return(nil)
          end

          it 'raise an error' do
            expect do
              subject.entity
            end.to raise_error(SyspaySDK::Exceptions::EMSError, "Chargeback event received with no chargeback data. Error code : #{SyspaySDK::EMS::CODE_INVALID_CONTENT}")
          end
        end
      end

      context 'When type is billing_agreement' do
        let(:billing_agreement) { double(:billing_agreement) }
        let(:type) { 'billing_agreement' }

        context 'When the billing_agreement object is available in data' do
          before do
            allow(data).to receive(:[]).with(:billing_agreement).and_return(billing_agreement)
          end

          it 'calls SyspaySDK::Entities::BillingAgreement.build_from_response' do
            expect(SyspaySDK::Entities::BillingAgreement).to receive(:build_from_response).with(billing_agreement).and_return(billing_agreement)

            expect(subject.entity).to eq(billing_agreement)
          end
        end

        context 'When the billing_agreement object is not available in data' do
          before do
            allow(data).to receive(:[]).with(:billing_agreement).and_return(nil)
          end

          it 'raise an error' do
            expect do
              subject.entity
            end.to raise_error(SyspaySDK::Exceptions::EMSError, "BillingAgreement event received with no billing_agreement data. Error code : #{SyspaySDK::EMS::CODE_INVALID_CONTENT}")
          end
        end
      end

      context 'When type is subscription' do
        let(:subscription) { double(:subscription) }
        let(:type) { 'subscription' }

        context 'When the subscription object is available in data' do
          before do
            allow(data).to receive(:[]).with(:subscription).and_return(subscription)
          end

          it 'calls SyspaySDK::Entities::Subscription.build_from_response' do
            expect(SyspaySDK::Entities::Subscription).to receive(:build_from_response).with(subscription).and_return(subscription)

            expect(subject.entity).to eq(subscription)
          end
        end

        context 'When the subscription object is not available in data' do
          before do
            allow(data).to receive(:[]).with(:subscription).and_return(nil)
          end

          it 'raise an error' do
            expect do
              subject.entity
            end.to raise_error(SyspaySDK::Exceptions::EMSError, "Subscription event received with no subscription data. Error code : #{SyspaySDK::EMS::CODE_INVALID_CONTENT}")
          end
        end
      end

      context 'When type is unknown' do
        let(:type) { 'unknown' }

        it 'raise an error' do
          expect do
            subject.entity
          end.to raise_error(SyspaySDK::Exceptions::EMSError, "Unknown type : #{type}. Error code : #{SyspaySDK::EMS::CODE_INVALID_CONTENT}")
        end
      end
    end
  end
end
