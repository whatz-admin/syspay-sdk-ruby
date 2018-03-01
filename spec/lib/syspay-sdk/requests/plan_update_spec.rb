describe SyspaySDK::Requests::PlanUpdate do
  it 'is a SyspaySDK::Requests::BaseClass' do
    is_expected.to be_a(SyspaySDK::Requests::BaseClass)
  end

  describe 'Constants' do
    it "has a METHOD class constant set to 'PUT'" do
      expect(described_class::METHOD).to eq('PUT')
    end

    it "has a PATH class constant set to '/api/v1/merchant/plan/'" do
      expect(described_class::PATH).to eq('/api/v1/merchant/plan/')
    end
  end

  describe 'Attributes' do
    it { is_expected.to respond_to(:plan_id) }
    it { is_expected.to respond_to(:trial_amount) }
    it { is_expected.to respond_to(:initial_amount) }
    it { is_expected.to respond_to(:billing_amount) }
  end

  describe 'Initialize' do
    it 'can be initialized with a plan_id parameter' do
      plan_update = described_class.new 'id'
      expect(plan_update.plan_id).to eq('id')
    end

    it 'can be initialized without arguments' do
      plan_update = described_class.new
      expect(plan_update.plan_id).to be_nil
    end
  end

  it { is_expected.to respond_to(:http_method) }

  describe '#http_method' do
    it 'returns the METHOD constant' do
      expect(subject.http_method).to eq(described_class::METHOD)
    end
  end

  it { is_expected.to respond_to(:path) }

  describe '#path' do
    it 'returns the PATH constant' do
      expect(subject.path).to eq(described_class::PATH)
    end
    it 'returns the PATH constant with plan_id if exists' do
      with_plan_id = described_class.new
      with_plan_id.plan_id = 'test_plan_id'
      expect(with_plan_id.path).to eq("#{described_class::PATH}test_plan_id")
    end
  end

  it { is_expected.to respond_to(:build_response) }

  describe '#build_response' do
    it 'raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in' do
      expect do
        subject.build_response('test')
      end.to raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain the plan" do
      expect do
        subject.build_response(test: 'test')
      end.to raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it 'returns an SyspaySDK::Entities::Plan' do
      expect(subject.build_response(plan: {})).to be_a(SyspaySDK::Entities::Plan)
    end
  end

  it { is_expected.to respond_to(:data) }

  describe '#data' do
    it 'returns a hash' do
      expect(subject.data).to be_a(Hash)
    end

    describe 'the returned hash' do
      it 'contains the plan_id' do
        subject.plan_id = 'plan_id'
        expect(subject.data).to include(plan_id: 'plan_id')
      end

      it 'contains the trial_amount' do
        subject.trial_amount = 'trial_amount'
        expect(subject.data).to include(trial_amount: 'trial_amount')
      end

      it 'contains the initial_amount' do
        subject.initial_amount = 'initial_amount'
        expect(subject.data).to include(initial_amount: 'initial_amount')
      end

      it 'contains the billing_amount' do
        subject.billing_amount = 'billing_amount'
        expect(subject.data).to include(billing_amount: 'billing_amount')
      end
    end
  end
end
