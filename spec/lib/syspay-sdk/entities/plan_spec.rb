require 'spec_helper'

describe SyspaySDK::Entities::Plan do
  it 'is a SyspaySDK::Entities::ReturnedEntity' do
    is_expected.to be_a(SyspaySDK::Entities::ReturnedEntity)
  end

  describe 'Constants' do
    it "has a TYPE class constant set to 'plan'" do
      expect(described_class::TYPE).to eq('plan')
    end

    describe 'TIME UNITS' do
      it "has a UNIT_MINUTE class constant set to 'minute'" do
        expect(described_class::UNIT_MINUTE).to eq('minute')
      end

      it "has a UNIT_HOUR class constant set to 'hour'" do
        expect(described_class::UNIT_HOUR).to eq('hour')
      end

      it "has a UNIT_DAY class constant set to 'day'" do
        expect(described_class::UNIT_DAY).to eq('day')
      end

      it "has a UNIT_WEEK class constant set to 'week'" do
        expect(described_class::UNIT_WEEK).to eq('week')
      end

      it "has a UNIT_MONTH class constant set to 'month'" do
        expect(described_class::UNIT_MONTH).to eq('month')
      end

      it "has a UNIT_YEAR class constant set to 'year'" do
        expect(described_class::UNIT_YEAR).to eq('year')
      end

      it 'has a TIME_UNITS array class constant' do
        expect(described_class::TIME_UNITS).to eq([
                                                    described_class::UNIT_MINUTE,
                                                    described_class::UNIT_HOUR,
                                                    described_class::UNIT_DAY,
                                                    described_class::UNIT_WEEK,
                                                    described_class::UNIT_MONTH,
                                                    described_class::UNIT_YEAR
                                                  ])
      end
    end

    it "has a TYPE_SUBSCRIPTION class constant set to 'SUBSCRIPTION'" do
      expect(described_class::TYPE_SUBSCRIPTION).to eq('SUBSCRIPTION')
    end

    it "has a TYPE_INSTALMENT class constant set to 'INSTALMENT'" do
      expect(described_class::TYPE_INSTALMENT).to eq('INSTALMENT')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:created) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:type) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:currency) }
    it { is_expected.to respond_to(:trial_amount) }
    it { is_expected.to respond_to(:trial_period) }
    it { is_expected.to respond_to(:trial_period_unit) }
    it { is_expected.to respond_to(:trial_cycles) }
    it { is_expected.to respond_to(:initial_amount) }
    it { is_expected.to respond_to(:billing_amount) }
    it { is_expected.to respond_to(:billing_period) }
    it { is_expected.to respond_to(:billing_period_unit) }
    it { is_expected.to respond_to(:billing_cycles) }
    it { is_expected.to respond_to(:retry_map_id) }
    it { is_expected.to respond_to(:total_amount) }
  end

  describe '::build_from_response' do
    it "doesn't raise an error when called" do
      expect do
        described_class.build_from_response(test: 'test')
      end.to_not raise_error
    end

    it 'returns a Plan object' do
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
        status: 'status',
        name: 'name',
        description: 'description',
        currency: 'currency',
        trial_amount: 'trial_amount',
        trial_period: 'trial_period',
        trial_period_unit: 'trial_period_unit',
        trial_cycles: 'trial_cycles',
        billing_amount: 'billing_amount',
        billing_period: 'billing_period',
        billing_period_unit: 'billing_period_unit',
        billing_cycles: 'billing_cycles',
        initial_amount: 'initial_amount',
        retry_map_id: 'retry_map_id',
        type: 'type'
      }
    end

    before(:each) do
      @plan = described_class.build_from_response(response)
    end

    it 'sets instance raw attribute to response' do
      expect(@plan.raw).to eq(response)
    end

    it 'sets instance id attribute using value in response' do
      expect(@plan.id).to eq(response[:id])
    end

    it 'sets instance status attribute using value in response' do
      expect(@plan.status).to eq(response[:status])
    end

    it 'sets instance name attribute using value in response' do
      expect(@plan.name).to eq(response[:name])
    end

    it 'sets instance description attribute using value in response' do
      expect(@plan.description).to eq(response[:description])
    end

    it 'sets instance currency attribute using value in response' do
      expect(@plan.currency).to eq(response[:currency])
    end

    it 'sets instance trial_amount attribute using value in response' do
      expect(@plan.trial_amount).to eq(response[:trial_amount])
    end

    it 'sets instance trial_period attribute using value in response' do
      expect(@plan.trial_period).to eq(response[:trial_period])
    end

    it 'sets instance trial_period_unit attribute using value in response' do
      expect(@plan.trial_period_unit).to eq(response[:trial_period_unit])
    end

    it 'sets instance trial_cycles attribute using value in response' do
      expect(@plan.trial_cycles).to eq(response[:trial_cycles])
    end

    it 'sets instance billing_amount attribute using value in response' do
      expect(@plan.billing_amount).to eq(response[:billing_amount])
    end

    it 'sets instance billing_period attribute using value in response' do
      expect(@plan.billing_period).to eq(response[:billing_period])
    end

    it 'sets instance billing_period_unit attribute using value in response' do
      expect(@plan.billing_period_unit).to eq(response[:billing_period_unit])
    end

    it 'sets instance billing_cycles attribute using value in response' do
      expect(@plan.billing_cycles).to eq(response[:billing_cycles])
    end

    it 'sets instance initial_amount attribute using value in response' do
      expect(@plan.initial_amount).to eq(response[:initial_amount])
    end

    it 'sets instance retry_map_id attribute using value in response' do
      expect(@plan.retry_map_id).to eq(response[:retry_map_id])
    end

    it 'sets instance type attribute using value in response' do
      expect(@plan.type).to eq(response[:type])
    end

    it 'sets instance created attribute using value in response' do
      created = Date.new(2001, 2, 3)
      response[:created] = created.to_time.to_i
      expect(described_class.build_from_response(response).created).to eq(created)
    end
  end
end
