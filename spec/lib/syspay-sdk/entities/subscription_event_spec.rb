require 'spec_helper'

describe SyspaySDK::Entities::SubscriptionEvent do
  it 'is a SyspaySDK::Entities::ReturnedEntity' do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe 'Constants' do
    it "has a TYPE class constant set to 'subscription_event'" do
      expect(described_class::TYPE).to eq('subscription_event')
    end
    it "has a TYPE_TRIAL class constant set to 'TRIAL'" do
      expect(described_class::TYPE_TRIAL).to eq('TRIAL')
    end

    it "has a TYPE_FREE_TRIAL class constant set to 'FREE_TRIAL'" do
      expect(described_class::TYPE_FREE_TRIAL).to eq('FREE_TRIAL')
    end

    it "has a TYPE_INITIAL class constant set to 'INITIAL'" do
      expect(described_class::TYPE_INITIAL).to eq('INITIAL')
    end

    it "has a TYPE_BILL class constant set to 'BILL'" do
      expect(described_class::TYPE_BILL).to eq('BILL')
    end

    it "has a TYPE_END class constant set to 'END'" do
      expect(described_class::TYPE_END).to eq('END')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:scheduled_date) }
    it { is_expected.to respond_to(:event_type) }
  end

  describe '::build_from_response' do
    it "doesn't raise an error when called" do
      expect do
        described_class.build_from_response(test: 'test')
      end.to_not raise_error
    end

    it 'returns a SubscriptionEvent object' do
      expect(described_class.build_from_response(test: 'test')).to be_a(described_class)
    end

    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        described_class.build_from_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    let(:response) do
      { event_type: 'event_type' }
    end

    before(:each) do
      @subscription_event = described_class.build_from_response(response)
    end

    it 'sets instance raw attribute to response' do
      expect(@subscription_event.raw).to eq(response)
    end

    it 'sets instance event_type attribute using value in response' do
      expect(@subscription_event.event_type).to eq(response[:event_type])
    end

    it 'sets instance scheduled_date attribute using value in response' do
      scheduled_date = Date.new(2001, 2, 3)
      response[:scheduled_date] = scheduled_date.to_time.to_i
      expect(described_class.build_from_response(response).scheduled_date).to eq(scheduled_date)
    end
  end
end
