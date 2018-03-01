describe SyspaySDK do
  describe 'Static methods' do
    describe 'configure' do
      it 'calls Config.configure with the same arguments' do
        block = proc { |_test| false }
        options = { foo: 'bar' }

        expect(SyspaySDK::Config).to receive(:configure).with(options, &block)

        SyspaySDK.configure options, &block
      end
    end

    describe 'load' do
      it 'calls Config.load with the same arguments' do
        args = { foo: 'bar' }

        expect(SyspaySDK::Config).to receive(:load).with args

        SyspaySDK.load args
      end
    end

    describe 'logger' do
      it 'calls Config.logger with the same arguments' do
        logger = double :logger

        expect(SyspaySDK::Config).to receive(:logger).and_return logger

        expect(SyspaySDK.logger).to eq logger
      end
    end

    describe 'logger=' do
      it 'calls Config.logger= with the same arguments' do
        logger = double :logger

        expect(SyspaySDK::Config).to receive(:logger=).with logger

        SyspaySDK.logger = logger
      end
    end
  end
end
